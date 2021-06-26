extends Node2D

class_name LevelMap

onready var blue_home : Home = $BlueHome
onready var red_home : Home = $RedHome
onready var tile_skeleton : TileMap = $TileMapSkeleton
export var level_name : String = "core"

# Make an INBUILT script and do the following for any inherited LevelMap:
# DO NOT edit the NavPolyInstance and instead make your own NavigationPolygonInstance to ensure no overwriting
# func _ready() -> void:
	# level_name = "basic"
	# $Navigator/NavPolyInstance.set_enabled(false)
	# $Navigator/NavPolyInstance.queue_free()
	# $Navigator/NavigationPolygonInstance.set_enabled(true)
