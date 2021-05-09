extends KinematicBody2D
class_name EnemyWeapon

export var speed := 400.0
export var damage := 10.0

var start : Vector2
var _velocity : Vector2
var target : Vector2

func _physics_process(delta: float) -> void:
	self.global_position += _velocity * delta

func fire(src : Vector2, dest : Vector2) -> void:
	start = src
	_velocity = (dest - src).normalized() * speed
	self.global_position = src
	look_at(dest)
