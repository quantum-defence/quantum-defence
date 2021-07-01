extends Area2D
class_name EnemySpawnPoint

onready var ENEMY_TYPES = {
	"core" : preload("res://src/enemy/core/Enemy.tscn"),
	"sabre" : preload("res://src/enemy/sabre/Sabre.tscn")
}

signal on_new_spawn_cycle(cycle_number, duration)
signal on_max_cycle_reached
signal on_enemy_kia
signal on_enemy_spawn
signal on_last_enemy_dead

# hidden state variables
var _spawn_config: Array;
var _max_spawn_cycle: int;
var cycle_number : int = 0

var cycle_timer : Timer
var living_enemy_count: int = 0

func _ready() -> void:
	set_process(false)

func begin_prep_clock(spawn_config : Array = []) -> void:
	_spawn_config = spawn_config.duplicate(true)
	_max_spawn_cycle = spawn_config.size()
	
	cycle_timer = Timer.new()
	cycle_timer.wait_time = _spawn_config[cycle_number].duration
	cycle_timer.autostart = false
	cycle_timer.one_shot = true
	cycle_timer.connect("timeout", self, "_new_cycle")
	
	add_child(cycle_timer)
	_new_cycle()

func _new_cycle() -> void:
	var next_cycle : Dictionary = _spawn_config.pop_front()
	emit_signal("on_new_spawn_cycle", cycle_number, next_cycle.duration)
	cycle_timer.wait_time = next_cycle.duration
	for type in next_cycle.enemy_queue:
		spawn_enemy(type)
		
	cycle_number += 1
	if cycle_number < _max_spawn_cycle:
		cycle_timer.start();
	else:
		emit_signal("on_max_cycle_reached")

func spawn_enemy(enemy_type: String) -> void:
	living_enemy_count += 1
	var enemy : Enemy = ENEMY_TYPES[enemy_type].instance()
	enemy.connect("kia", self, "register_kia")
	get_parent().add_child_below_node(self, enemy)
	enemy.set_up(
		self.global_position, 
		get_parent().get_node("RedHome"),
		get_parent().get_node("BlueHome"))
	emit_signal("on_enemy_spawn")

func register_kia() -> void:
	emit_signal("on_enemy_kia")
	living_enemy_count -= 1
	if _max_spawn_cycle < cycle_number:
		emit_signal("on_last_enemy_dead")
