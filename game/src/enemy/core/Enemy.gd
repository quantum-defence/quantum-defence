extends KinematicBody2D
class_name Enemy

# % of random movement to avoid the 'queue' clustering effect'
const RAND_WALK_EFFECT := 50
const RANDOM_WALK_DIST := 128.0 * 0.4

# basic enemy variables
var _speed := 200.0
var _health := 100.0
var _target : Home

# current enemy behaviour
var action
enum ACTION { IDLE, MOVE, ATTACK, TAKE_DAMAGE, DIE }

# durations for freezing in a certain behaviour
var damage_taken_time := 0.5
var death_rattle_time := 2.0
var attack_time := 2.0

var path := PoolVector2Array()
var _is_reached := false

onready var sprite : AnimatedSprite = $Sprite
onready var damage_taken_timer : Timer = $DamageTakenTimer
onready var attack_timer : Timer = $AttackTimer
onready var collision_timer : Timer = $CollisionTimer

func _ready() -> void:
	action = self.ACTION.IDLE
	self.sprite.play("idle")
	self.add_to_group("enemies")
	collision_timer.set_paused(true)

func _physics_process(delta: float) -> void:
	if action == ACTION.DIE:
		return
	elif !damage_taken_timer.is_stopped():
		return
	elif not _is_reached:
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
	else:
		attack()

func _move_along_path(distance: float) -> void:
	action = self.ACTION.MOVE
	if sprite.get_animation() != "move":
		sprite.play("move")
	
	var start_point := position
	
	if path.size() == 0:
		return
	var distance_to_next := start_point.distance_to(path[0])
	if  distance_to_next == 0:
		path.remove(0)
		return
	if distance > distance_to_next or distance < 0.0:
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		_move_along_path(distance)
		return
	
	var next_position := start_point.linear_interpolate(
		path[0], distance / distance_to_next)
	var randVect := Vector2(randf()-0.5, randf()-0.5) / 100
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

# fire weapon at home
func attack() -> void:
	if !attack_timer.is_stopped():
		return
	action = self.ACTION.ATTACK
	sprite.play("attack")
	attack_timer.start()
	var weapon = preload("res://src/projectile/enemy-weapon/EnemyWeapon.tscn").instance()
	weapon.fire(global_position, _target)
	get_parent().add_child(weapon)

# take damage
func take_damage(damage_taken: float) -> void:
	_health -= damage_taken
	if _health <= 0.0:
		_kill()
		return
	
	damage_taken_timer.start(damage_taken_time)
	if action != ACTION.TAKE_DAMAGE:
		sprite.play("take_damage")
		action = ACTION.TAKE_DAMAGE

func _kill() -> void:
	action = ACTION.DIE
	damage_taken_timer.start(death_rattle_time)
	sprite.play("die")
	# warning-ignore:return_value_discarded
	damage_taken_timer.connect("timeout", self, "queue_free")

func set_target(target : Home) -> void:
	_target = target
	path = _set_target(target.global_position - self.global_position)

func _set_target(relative_position_target : Vector2) -> PoolVector2Array:
	var nav : Navigation2D
	nav = get_parent().get_node("Navigator")
	return nav.get_simple_path(global_position, global_position + relative_position_target, true)

# registers when home has been encountered
func _on_Range_area_entered(area: Area2D) -> void:
	if area is Home:
		_is_reached = true

func _on_body_entering_vitals(body: Node) -> void:
	if body is Projectile:
		# warning-ignore:unsafe_method_access
		body.inflict_damage(self)