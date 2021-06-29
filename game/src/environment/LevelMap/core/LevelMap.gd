extends Node2D

class_name LevelMap

signal on_prep_time_start(duration)
signal on_spawn_cycle(cycle_number, duration)
signal on_cooldown_cycle(cycle_number, duration)
signal on_game_end(is_win, blue_health, red_health, cycle_number, enemy_spawn_count, enemy_kill_count)
signal on_enemy_death
signal on_last_cycle

onready var blue_home : Home = $BlueHome
onready var red_home : Home = $RedHome
onready var tile_skeleton : TileMap = $TileMapSkeleton
onready var initial_items : Array = ['h', 'x', 'ry']
export var level_name : String = "core"

var prep_time := 6.0
var spawn_rate := 0.8
var spawn_on_time := 10.0
var spawn_off_time := 20.0
var max_spawn_cycle := 4

var blue_health := 100
var red_health := 100
var enemy_spawn_count := 0
var enemy_kill_count := 0
var cycle_number := 0

func _ready() -> void:
	var spawn_point : EnemySpawnPoint = $EnemySpawnPoint
	spawn_point.spawn_off_time = spawn_off_time
	spawn_point.spawn_on_time = spawn_on_time
	spawn_point.max_spawn_cycle = max_spawn_cycle
	spawn_point.spawn_rate = spawn_rate
	spawn_point.begin_prep_clock(prep_time)

# Make an INBUILT script and do the following for any inherited LevelMap:
# DO NOT edit the NavPolyInstance and instead make your own NavigationPolygonInstance to ensure no overwriting
# func _ready() -> void:
	# level_name = "basic"
	# $Navigator/NavPolyInstance.set_enabled(false)
	# $Navigator/NavPolyInstance.queue_free()
	# $Navigator/NavigationPolygonInstance.set_enabled(true)

func _on_prep_start(duration) -> void:
	# print("on prep start " + str(duration))
	emit_signal("on_prep_time_start", duration)

func _on_home_damage(isRed, health) -> void:
	# print("home damage" + " red " if isRed else " blue " + str(health))
	if isRed:
		red_health = health
	else:
		blue_health = health
	if (blue_health <= 0 or red_health <= 0):
		emit_signal("on_game_end", false, blue_health, red_health, cycle_number, enemy_spawn_count, enemy_kill_count)

func _on_enemy_kia() -> void:
	enemy_kill_count += 1
	emit_signal("on_enemy_death")

func _on_enemy_spawn() -> void:
	enemy_spawn_count += 1

func _on_last_enemy_dead() -> void:
	if (blue_health > 0 and red_health > 0):
		emit_signal("on_game_end", true, blue_health, red_health, cycle_number, enemy_spawn_count, enemy_kill_count)

func _on_max_cycle_reached() -> void:
	emit_signal("on_last_cycle")

func _on_spawn_cycle_change(is_spawning, cycle_number, duration) -> void:
	self.cycle_number = cycle_number
	if is_spawning:
		emit_signal("on_spawn_cycle", cycle_number, duration)
	else:
		emit_signal("on_cooldown_cycle", cycle_number, duration)
