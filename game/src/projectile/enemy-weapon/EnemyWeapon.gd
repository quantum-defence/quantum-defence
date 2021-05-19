extends Projectile

func _ready() -> void:
	pass

func inflict_damage(body : Node2D) -> void:
	if body.is_in_group("enemies"):
		return
	.inflict_damage(body)
