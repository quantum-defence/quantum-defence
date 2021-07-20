extends Area2D
class_name Portal

signal on_hit(isRed, health)

export var health := 80.0
onready var sprite: AnimatedSprite = $AnimatedSprite
export var isRed: bool = false
onready var health_bar = self.find_parent("Arena").get_node("UI/Control/HealthBar")

func _ready() -> void:
	sprite.play("red" if isRed else "blue")


func set_up(health:int):
	self.health = health
	health_bar.set_portal_health(health, isRed)

func teleport(enemy: Enemy) -> void:
	var damage_taken = enemy.damage
	enemy.show_teleportation()
	self.health -= damage_taken
	emit_signal("on_hit", isRed, self.health)
	sprite.play("teleport")


# Watches for enemy weapon hits
func _on_Base_body_entered(body: Node) -> void:
	if body is Enemy:
		var enemy: Enemy = body
		teleport(enemy)
		emit_signal("take_damage", body.damage, health)
		self.health -= body.damage
		health_bar.set_portal_health(self.health, isRed)
	return
