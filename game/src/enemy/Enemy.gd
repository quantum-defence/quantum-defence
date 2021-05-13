extends KinematicBody2D

# Random movement to avoid the 'queue' clustering effect'
onready var RAND_EFFECT := 2.0

# enemy body specific constants
export var speed := 400.0
export var _corpse_timer := 5.0
export var _rate_of_fire := 2.0

# enemy state variables
var _health := 100.0
var _target : Vector2
var _last_fire := 0.0
var path := PoolVector2Array()
var _is_reached := false

signal enemy_dead

func _physics_process(delta: float) -> void:
	if not _is_reached:
		move_along_path(delta * speed)
	elif _last_fire > 1.0 / _rate_of_fire:
		_last_fire = 0.0
		fire()
	else:
		_last_fire += delta

	if _health <= 0.0:
		kill()
		_corpse_timer -= delta
	if _corpse_timer <= 0.0:
		queue_free()
	
func move_along_path(distance : float) -> void:
	var start_point := position
	for _i in range(path.size()):
		var distance_to_next := start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			var next_position := start_point.linear_interpolate(
				path[0], distance / distance_to_next)
			var randVect := Vector2(randf()-0.5, randf()-0.5) 
			randVect = randVect * distance
			randVect = randVect * RAND_EFFECT
			move_and_collide(next_position - position + randVect)
			break
		elif distance < 0.0:
			_is_reached = true
			move_and_collide(path[0] - position)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
func set_path(value : PoolVector2Array) -> void:
	path = value
	_is_reached = false

# fire weapon at home
func fire() -> void:
	var weapon = preload("res://src/enemy/EnemyWeapon.tscn").instance()
	get_parent().add_child(weapon)
	weapon.fire(global_position, _target)

# to be run when health reaches 0
func kill() -> void:
	_health = 0.0
	$Sprite.set_animation("dead")
	emit_signal("enemy_dead")

# refresh home location
# currently not in use, safe to delete
func set_target(target : Vector2):
	_target = target
	var nav : Navigation2D
	nav = get_parent().get_node("Navigator")
	path = nav.get_simple_path(global_position, target, true)

# registers when home has been encountered
func _on_Range_area_entered(area: Area2D) -> void:
	if area is Home:
		_is_reached = true
