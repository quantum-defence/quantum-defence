extends Area2D
class_name Home

onready var health := 100.0
onready var sprite : AnimatedSprite = $AnimatedSprite
onready var damage_taken_timer : Timer = $Timer
export var isRed : bool = false
const damage_taken_time = 0.2

func _ready() -> void:
	$MarginContainer/HBoxContainer/Label.set_text("HEALTH - " + str(health))

func _process(_delta: float) -> void:
	$MarginContainer/HBoxContainer/Label.set_text("HEALTH - " + str(health))
	if damage_taken_timer.is_stopped():
		sprite.play("live")

func take_damage(damage_taken: float, _isFlip: bool = false, _isRed: bool = false) -> void:
	self.health -= damage_taken
	if health <= 0.0:
		health = 0.0
		sprite.play("take_damage")
		$MarginContainer/HBoxContainer/Label.set_text("GAME OVER")
		set_process(false)
		return
	
	damage_taken_timer.start(damage_taken_time)
	sprite.play("take_damage")

# Watches for enemy weapon hits
func _on_Base_body_entered(body: Node) -> void:
	if body is Projectile:
		body.inflict_damage(self)
		emit_signal("take_damage", body.damage, health)
	return
