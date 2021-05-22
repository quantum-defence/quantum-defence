extends Area2D
class_name Home

onready var health := 100.0

func _ready() -> void:
	$MarginContainer/HBoxContainer/HealthVal.set_text(str(health))

func take_damage(damage: float) -> void:
	self.health -= damage

# Watches for enemy weapon hits
func _on_Base_body_entered(body: Node) -> void:
	print("smth")
	if body is Projectile:
		body.inflict_damage(self)
		$MarginContainer/HBoxContainer/HealthVal.set_text(str(health))
		emit_signal("take_damage", body.damage, health)
	return
