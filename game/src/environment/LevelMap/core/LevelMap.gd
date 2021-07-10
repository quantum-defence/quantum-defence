extends Node2D

class_name LevelMap

signal on_spawn_cycle(cycle_number, duration)
signal on_game_end(is_win, blue_health, red_health, cycle_number, enemy_spawn_count, enemy_kill_count)
signal on_enemy_death
signal on_last_cycle

export var level_name : String = "core"
onready var blue_portal = $BluePortal
onready var red_portal = $RedPortal
onready var tile_skeleton : TileMap = $TileMapSkeleton
onready var initial_items : Array = ['h', 'x', 'ry']
var prebuilt_towers : Array = [
	{ 
		'tower_res_string': "res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn", 
		'x': 4, 'y': 7, 'colour': "red" 
	},
	{ 
		'tower_res_string': "res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn", 
		'x': 9, 'y': 4, 'colour': "red" 
	},
	{ 
		'tower_res_string': "res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn", 
		'x': 16, 'y': 4, 'colour': "blue" 
	},
]

var spawn_config : Array = [
	{ 'duration': 6.0, 'enemy_queue': [] },
	{
		'duration': 40.0,
		'enemy_queue': [ 
			"sabre", "core", "sabre", 
			"sabre", "core", "sabre",
			"sabre", "core", "sabre",
		]
	},
	{
		'duration': 40.0,
		'enemy_queue': [ 
			"core", "core", "sabre", "sabre",
			"core", "core", "sabre", "sabre",
			"core", "core", "sabre", "sabre",
		]
	},
];

var blue_health := 100
var red_health := 100
var enemy_spawn_count := 0
var enemy_kill_count := 0
var _cycle_number := 0

func set_up() -> void:
	var spawn_point = $EnemySpawnPoint
	spawn_point.begin_prep_clock(spawn_config)

# Make an INBUILT script and do the following for any inherited LevelMap:
# DO NOT edit the NavPolyInstance and instead make your own NavigationPolygonInstance to ensure no overwriting
# func _ready() -> void:
	# level_name = "basic"
	# $Navigator/NavPolyInstance.set_enabled(false)
	# $Navigator/NavPolyInstance.queue_free()
	# $Navigator/NavigationPolygonInstance.set_enabled(true)
	# initial_items = ..
	# prebuilt_towers = ..
	# spawn_config = 

func _on_portal_damage(isRed, health) -> void:
	if isRed:
		red_health = health
	else:
		blue_health = health
	if (blue_health <= 0 or red_health <= 0):
		emit_signal("on_game_end", false, blue_health, red_health, _cycle_number, enemy_spawn_count, enemy_kill_count)

func _on_enemy_kia() -> void:
	enemy_kill_count += 1
	emit_signal("on_enemy_death")

func _on_enemy_spawn() -> void:
	enemy_spawn_count += 1

func _on_last_enemy_dead() -> void:
	if (blue_health > 0 and red_health > 0):
		emit_signal("on_game_end", true, blue_health, red_health, _cycle_number, enemy_spawn_count, enemy_kill_count)

func _on_max_cycle_reached() -> void:
	emit_signal("on_last_cycle")

func _on_new_spawn_cycle(cycle_number, duration) -> void:
	_cycle_number = cycle_number
	emit_signal("on_spawn_cycle", cycle_number, duration)
