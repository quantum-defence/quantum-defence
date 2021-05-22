extends KinematicBody2D
class_name Projectile

export var speed := 200.0
export var damage := 20.0

# enemy state variables
var origin : Vector2
var target : Node2D

func _ready() -> void:
	self.global_position = origin
	if target == null or weakref(target).get_ref() == null:
		_stop()
	else:
		look_at(target.position)

func _physics_process(delta: float) -> void:
	_move_toward_target(delta)

func fire(src: Vector2, dest: Node2D) -> void:
	origin = src
	target = dest

func _move_toward_target(delta: float) -> void:
	if target == null or weakref(target).get_ref() == null:
		_stop()
		return
		
	var direction := target.position
	direction -= position
	var velocity := direction.normalized() * speed
	self.position += velocity * delta
	self.look_at(target.position)

func _stop() -> void:
	queue_free()

func inflict_damage(body : Node2D) -> void:
	if body == target:
		body.take_damage(damage)
		self.queue_free()
