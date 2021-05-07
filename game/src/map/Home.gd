extends Area2D

signal take_damage(damage, new_health)
var _health : float

func _ready() -> void:
	_health = 100.0

func _on_Base_body_entered(body: Node) -> void:
	if body.name == "EnemyWeapon":
		_health -= body.damage
		$MarginContainer/HBoxContainer/HealthVal.set_text(str(_health))
		emit_signal("take_damage", body.damage, _health)
	return
