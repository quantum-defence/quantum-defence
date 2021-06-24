extends Area2D
class_name EnemySpawnPoint

onready var ENEMY_TYPES = {
	"CORE" : preload("res://src/enemy/core/Enemy.tscn"),
	"SABRE" : preload("res://src/enemy/sabre/Sabre.tscn")
}

# constants
export var spawn_rate := 0.5
export var on_off_interval := [4,16]

# hidden state variables
var _last_spawn := 0.0
var is_spawning : bool = true
var cooldown_timer : Timer
var spawn_timer : Timer

func _ready() -> void:
	cooldown_timer = Timer.new()
	spawn_timer = Timer.new()
	cooldown_timer.wait_time = on_off_interval[1]
	spawn_timer.wait_time = on_off_interval[0]
	cooldown_timer.autostart = false
	spawn_timer.autostart = false
	cooldown_timer.one_shot = true
	spawn_timer.one_shot = true
	add_child(cooldown_timer)
	add_child(spawn_timer)
	spawn_timer.start()

func _process(delta: float) -> void:
	if is_spawning:
		if spawn_timer.is_stopped():
			cooldown_timer.start()
			is_spawning = false
	else: 
		if cooldown_timer.is_stopped():
			spawn_timer.start()
			is_spawning = true
	if !is_spawning:
		return
	elif _last_spawn > 1.0 / spawn_rate:
		_last_spawn = 0.0
		spawn()
	_last_spawn += delta

func spawn() -> void:
	var enemy = ENEMY_TYPES.SABRE.instance()
	get_parent().add_child_below_node(self, enemy)
	enemy.set_up(
		self.global_position, 
		get_parent().get_node("RedHome"),
		get_parent().get_node("BlueHome"))
