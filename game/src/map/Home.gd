extends Area2D
class_name Home

signal take_damage(damage, new_health)
onready var _health := 100.0

func _on_Base_body_entered(body: Node) -> void:
	if body is EnemyWeapon:
		_health -= body.damage
		$MarginContainer/HBoxContainer/HealthVal.set_text(str(_health))
		emit_signal("take_damage", body.damage, _health)
	return
