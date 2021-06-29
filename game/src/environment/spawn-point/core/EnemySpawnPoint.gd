extends Area2D
class_name EnemySpawnPoint

onready var ENEMY_TYPES = {
	"CORE" : preload("res://src/enemy/core/Enemy.tscn"),
	"SABRE" : preload("res://src/enemy/sabre/Sabre.tscn")
}

# constants
var spawn_rate := 0.5
var spawn_on_time := 10.0
var spawn_off_time := 20.0
var max_spawn_cycle := 4

signal on_prep_start(duration)
signal on_spawn_cycle_change(is_spawning, cycle_number, duration)
signal on_max_cycle_reached
signal on_enemy_kia
signal on_enemy_spawn
signal on_last_enemy_dead

# hidden state variables
var _last_spawn := 0.0
var is_spawning : bool = true
var prep_timer : Timer
var cooldown_timer : Timer
var spawn_timer : Timer
var cycle_number : int = 0
var living_enemy_count: int = 0

func _ready() -> void:
	set_process(false)

func begin_prep_clock(prep_time: float) -> void:
	prep_timer = Timer.new()
	prep_timer.wait_time = prep_time
	prep_timer.autostart = false
	prep_timer.one_shot = true
	add_child(prep_timer)
	prep_timer.connect("timeout", self, "_begin_spawn_cycles")
	prep_timer.start()
	emit_signal("on_prep_start", prep_time)

func _begin_spawn_cycles() -> void:
	prep_timer.stop()
	prep_timer.queue_free()
	prep_timer = null
	
	cooldown_timer = Timer.new()
	spawn_timer = Timer.new()
	cooldown_timer.wait_time = spawn_off_time
	spawn_timer.wait_time = spawn_on_time
	cooldown_timer.autostart = false
	spawn_timer.autostart = false
	cooldown_timer.one_shot = true
	spawn_timer.one_shot = true
	
	add_child(cooldown_timer)
	add_child(spawn_timer)
	spawn_timer.start()
	emit_signal("on_spawn_cycle_change", true, cycle_number, spawn_on_time)
	set_process(true)

func _process(delta: float) -> void:
	if is_spawning:
		if spawn_timer.is_stopped():
			if max_spawn_cycle <= cycle_number:
				emit_signal("on_max_cycle_reached")
				set_process(false)
				return
			cooldown_timer.start()
			print('fasfsf')
			emit_signal("on_spawn_cycle_change", false, cycle_number, spawn_off_time)
			is_spawning = false
	else: 
		if cooldown_timer.is_stopped():
			cycle_number += 1
			spawn_timer.start()
			is_spawning = true
			emit_signal("on_spawn_cycle_change", true, cycle_number, spawn_on_time)
	if !is_spawning:
		return
	elif _last_spawn > 1.0 / spawn_rate:
		_last_spawn = 0.0
		spawn()
	_last_spawn += delta

func spawn() -> void:
	living_enemy_count += 1
	var enemy : Enemy = ENEMY_TYPES.SABRE.instance()
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
	if max_spawn_cycle <= cycle_number:
		emit_signal("on_last_enemy_dead")
