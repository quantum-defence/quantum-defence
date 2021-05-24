extends Area2D
class_name EnemySpawnPoint

onready var ENEMY_TYPES = {
	"CORE" : preload("res://src/enemy/core/Enemy.tscn"),
	"SABRE" : preload("res://src/enemy/sabre/Sabre.tscn")
}

# constants
export var spawn_rate := 1.0

# hidden state variables
var _last_spawn := 0.0

func _process(delta: float) -> void:
	if _last_spawn > 1.0 / spawn_rate:
		_last_spawn = 0.0
		spawn()
	_last_spawn += delta

func spawn() -> void:
	var enemy = ENEMY_TYPES.SABRE.instance()
	get_parent().add_child_below_node(self, enemy)
	enemy.global_position = self.global_position
	enemy.set_target(get_parent().get_node("Home"))
