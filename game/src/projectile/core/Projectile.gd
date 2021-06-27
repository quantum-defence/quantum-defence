extends KinematicBody2D
class_name Projectile

export var speed := 40.0
export var damage := 20.0

# enemy state variables
var origin : Vector2
var target : Node2D
var isTensor: bool = false
var _probs: Dictionary

func _ready() -> void:
	self.global_position = origin
	if target == null or weakref(target).get_ref() == null:
		_stop()
	else:
		look_at(target.position)

func set_prob(probs) -> void:
	isTensor = true
	_probs = probs

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
	var flip_state := false
	var isRed := false
	if body == target:
		if isTensor:
			flip_state = true
			isRed = randf() > _probs["1"]
		body.take_damage(damage, flip_state, isRed)
		self.queue_free()
