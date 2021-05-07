extends Area2D

export var spawn_rate := 0.04
var _last_spawn := 0.0

func _process(delta: float) -> void:
	if _last_spawn > 1.0 / spawn_rate:
		_last_spawn = 0.0
		spawn()
	_last_spawn += delta

func spawn() -> void:
	var enemy = preload("res://src/enemy/Enemy.tscn").instance()
	get_parent().add_child(enemy)
	enemy.global_position = self.global_position
	enemy.set_target(get_parent().get_node("Home").global_position)
