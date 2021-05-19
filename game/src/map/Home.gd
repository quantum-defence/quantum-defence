extends Area2D
class_name Home

signal take_damage(damage, new_health)
onready var health := 100.0

func _ready() -> void:
	$MarginContainer/HBoxContainer/HealthVal.set_text(str(health))

# Watches for enemy weapon hits
func _on_Base_body_entered(body: Node) -> void:
	if body is EnemyWeapon:
		body.inflict_damage(self)
		$MarginContainer/HBoxContainer/HealthVal.set_text(str(health))
		emit_signal("take_damage", body.damage, health)
	return
