extends KinematicBody2D
class_name Enemy

signal kia

# % of random movement to avoid the 'queue' clustering effect'
const RAND_WALK_EFFECT := 50
const RANDOM_WALK_DIST := 128.0 * 0.4

# basic enemy variables
var damage := 10.0
var _speed := 100.0
var _health := 100.0
var _target  # : Portal
var _red_target  # : Portal
var _blue_target  # : Portal

#
export var gold_dropped_min: int = 0
export var gold_dropped_max: int = 5
export var gold_drop_rate: int = 100

enum Q_STATE { SUPERPOSITION = 0, RED = 1, BLUE = 2 }
var qubit := Vector2()
var qubit_state: int = Q_STATE.SUPERPOSITION

# current enemy behaviour
var action
enum ACTION { IDLE, MOVE, ATTACK, TAKE_DAMAGE, DIE }

# durations for freezing in a certain behaviour
var damage_taken_time := 0.5
var death_rattle_time := 2.0
var attack_time := 2.0

var path := PoolVector2Array()

onready var sprite: AnimatedSprite = $Sprite
onready var damage_taken_timer: Timer = $DamageTakenTimer
onready var attack_timer: Timer = $AttackTimer
onready var collision_timer: Timer = $CollisionTimer

onready var build_UI = self.find_parent("Arena").get_node("UI/Control/BuildUI")


func _ready() -> void:
	action = self.ACTION.IDLE
	self.sprite.play("idle")
	self.add_to_group("enemies")
	collision_timer.set_paused(true)


func set_up(global_pos: Vector2, red_target, blue_target, is_red_probability = 0.5):  # : Portal,  # : Portal
	self.global_position = global_pos
	_red_target = red_target
	_blue_target = blue_target
	if randf() >= is_red_probability:
		change_state(Q_STATE.BLUE)
	else:
		change_state(Q_STATE.RED)


func _physics_process(delta: float) -> void:
	self.z_index = self.global_position.y / 10.0
	if action == ACTION.DIE:
		return
	elif ! damage_taken_timer.is_stopped():
		return

	if collision_timer.is_paused():
		if not _target:
			_set_new_random_walk()
		_move_along_path(delta * _speed)
	elif collision_timer.is_stopped() or path.size() == 0:
		collision_timer.set_paused(true)
		if _target:
			set_target(_target)
	else:
		_move_along_path(delta * _speed)


func _move_along_path(distance: float) -> void:
	action = self.ACTION.MOVE
	if sprite.get_animation() != "move":
		sprite.play("move")

	var start_point := position

	if path.size() == 0:
		return
	var distance_to_next := start_point.distance_to(path[0])
	if distance_to_next == 0:
		path.remove(0)
		return
	if distance > distance_to_next or distance < 0.0:
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		_move_along_path(distance)
		return

	var next_position := start_point.linear_interpolate(path[0], distance / distance_to_next)
	var randVect := Vector2(randf() - 0.5, randf() - 0.5) / 100
	randVect = Vector2(1, 1) + randVect * RAND_WALK_EFFECT
	var move_vector := (next_position - position) * randVect
	var collision = move_and_collide(move_vector)
	if collision:
		_set_new_random_walk()
		collision_timer.set_paused(false)
		collision_timer.start()


func _set_new_random_walk() -> void:
	var new_target := Vector2(randf() - 0.5, randf() - 0.5).normalized() * RANDOM_WALK_DIST
	path = _set_target(new_target)


# take damage
func take_damage(damage_taken: float, isFlip: bool = false, isRed: bool = false) -> void:
	_health -= damage_taken
	if _health <= 0.0:
		_kill()
		return

	if isFlip:
		if isRed:
			change_state(Q_STATE.RED)
		else:
			change_state(Q_STATE.BLUE)

	damage_taken_timer.start(damage_taken_time)
	if action != ACTION.TAKE_DAMAGE:
		sprite.play("take_damage")
		action = ACTION.TAKE_DAMAGE


func change_state(new_state: int) -> void:
	qubit_state = new_state
	match new_state:
		Q_STATE.RED:
			modulate = Color.red
			_target = _red_target
			set_collision_mask_bit(4, false)
			set_collision_mask_bit(5, true)
			set_collision_layer_bit(4, false)
			set_collision_layer_bit(5, true)
		Q_STATE.BLUE:
			modulate = Color.blue
			_target = _blue_target
			set_collision_mask_bit(5, false)
			set_collision_mask_bit(4, true)
			set_collision_layer_bit(5, false)
			set_collision_layer_bit(4, true)
	set_target(_target)


func _kill() -> void:
	if action == ACTION.DIE:
		return
	emit_signal("kia")
	action = ACTION.DIE
	damage_taken_timer.start(death_rattle_time)
	sprite.play("die")
	# warning-ignore:return_value_discarded
	damage_taken_timer.connect("timeout", self, "queue_free")

	#Make the gold appear above the enemies head when killed
	var gold_dropped = drop_gold()
	var gold_label = Label.new()
	self.add_child(gold_label)
	gold_label.text = str("+", gold_dropped, "Gold")


func show_teleportation() -> void:
	modulate = Color.white
	set_physics_process(false)
	emit_signal("teleport")
	var teleport_anim: AnimatedSprite = $TeleportAnimation
	teleport_anim.visible = true
	var main_sprite: AnimatedSprite = $Sprite
	main_sprite.visible = false
	teleport_anim.play("default")
	attack_timer.start(attack_time)
	attack_timer.connect("timeout", self, "queue_free")


func set_target(target) -> void:
	_target = target
	path = _set_target(target.global_position - self.global_position)


func _set_target(relative_position_target: Vector2) -> PoolVector2Array:
	var nav: Navigation2D
	nav = get_parent().get_node("Navigator")
	return nav.get_simple_path(global_position, global_position + relative_position_target, true)


func _on_body_entering_vitals(body: Node) -> void:
	if body is Projectile:
		# warning-ignore:unsafe_method_access
		body.inflict_damage(self)


func drop_gold() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var roll_drop_rate = rng.randi_range(0, 100)
	var gold_dropped
	if roll_drop_rate < gold_drop_rate:
		gold_dropped = rng.randi_range(gold_dropped_min, gold_dropped_max)
		print(gold_dropped)
		build_UI.change_gold(gold_dropped)
	return gold_dropped
