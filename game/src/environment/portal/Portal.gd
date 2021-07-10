extends Area2D
class_name Portal

signal on_hit(isRed, health)

onready var health := 100.0
onready var sprite : AnimatedSprite = $AnimatedSprite
export var isRed : bool = false

func _ready() -> void:
	sprite.play("red" if isRed else "blue")

func teleport(enemy: Enemy) -> void:
	var damage_taken = enemy.damage
	enemy.show_teleportation()
	self.health -= damage_taken
	emit_signal("on_hit", isRed, self.health)
	sprite.play("teleport")

# Watches for enemy weapon hits
func _on_Base_body_entered(body: Node) -> void:
	if body is Enemy:
		var enemy : Enemy = body
		teleport(enemy)
		emit_signal("take_damage", body.damage, health)
	return
