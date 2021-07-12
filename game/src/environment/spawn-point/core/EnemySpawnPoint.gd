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

var spawn_spacer : Timer
var current_cycle : Dictionary

func begin_prep_clock(spawn_config : Array = []) -> void:
	_spawn_config = spawn_config.duplicate(true)
	_max_spawn_cycle = spawn_config.size()
	
	cycle_timer = Timer.new()
	cycle_timer.wait_time = _spawn_config[cycle_number].duration
	cycle_timer.autostart = false
	cycle_timer.one_shot = true
	cycle_timer.connect("timeout", self, "_new_cycle")
	add_child(cycle_timer)
	
	spawn_spacer = Timer.new()
	spawn_spacer.wait_time = 0.2
	spawn_spacer.autostart = false
	spawn_spacer.one_shot = true
	spawn_spacer.connect("timeout", self, "spawn_queue_handler")
	add_child(spawn_spacer)
	
	_new_cycle()

func _new_cycle() -> void:
	if (_spawn_config.size() == 0):
		return
	current_cycle = _spawn_config.pop_front()
	current_cycle = current_cycle.duplicate(true)
	emit_signal("on_new_spawn_cycle", cycle_number, current_cycle.duration)
	cycle_timer.wait_time = current_cycle.duration
	
	if cycle_number < _max_spawn_cycle:
		cycle_timer.start();
		spawn_spacer.start()
	else:
		emit_signal("on_max_cycle_reached")
	
	cycle_number += 1

func spawn_queue_handler() -> void:
	if (current_cycle == null):
		return
	var queue : Array = current_cycle.enemy_queue
	
	if queue != null and queue.size() != 0:
		spawn_enemy(queue.pop_front())
		spawn_spacer.start()

func spawn_enemy(enemy_type: String) -> void:
	living_enemy_count += 1
	var enemy : Enemy = ENEMY_TYPES[enemy_type].instance()
	enemy.connect("kia", self, "register_kia")
	get_parent().add_child_below_node(self, enemy)
	enemy.set_up(
		self.global_position, 
		get_parent().get_node("RedPortal"),
		get_parent().get_node("BluePortal"))
	emit_signal("on_enemy_spawn")

func register_kia() -> void:
	living_enemy_count -= 1
	emit_signal("on_enemy_kia")

func register_teleported() -> void:
	living_enemy_count -= 1
	if living_enemy_count == 0 and _max_spawn_cycle == cycle_number:
		emit_signal("on_last_enemy_dead")
