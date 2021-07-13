extends Projectile


func _ready() -> void:
	damage = 10.0


func inflict_damage(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		return
	.inflict_damage(body)
