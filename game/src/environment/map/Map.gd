extends Node2D
class_name Arena

# DUPLICATE CODE: must also modify at tile selector
const TILE_SIZE = 64.0
enum TILE_CONTENTS { PATH, EMPTY, TOWER, HOME, INVALID = -1 }
enum ACTION { BUILDING, INSPECTING }

onready var tile_selector := $Selector
onready var tile_map : TileMap = $TileMapSkeleton
onready var home : Home = $Home
var tile_at
var tower_at

func _ready() -> void:
	tile_selector.set_action(ACTION.INSPECTING, "")
	tile_at = []
	tile_at.resize(90)
	for i in range(90):
		tile_at[i] = []
		tile_at[i].resize(90)
		for j in range(90):
			tile_at[i][j] = tile_map.get_cell(i, j)
	tile_at[home.position.x / TILE_SIZE][home.position.y / TILE_SIZE] = TILE_CONTENTS.HOME
	tower_at = []
	tower_at.resize(90)
	for i in range(90):
		tower_at[i] = []
		tower_at[i].resize(90)
		for j in range(90):
			tower_at[i][j] = tile_map.get_cell(i, j)

# dummy function to show use of selector
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var e : InputEventMouseButton = event
		if e.button_index == BUTTON_LEFT and e.pressed:
			tile_selector.take_action()
	elif event is InputEventMouseMotion:
		var e : InputEventMouseMotion = event
		select_using_position(e.position)

func select_using_position(relative_to_map: Vector2) -> void:
	var x = floor(relative_to_map.x / TILE_SIZE)
	var y = floor(relative_to_map.y / TILE_SIZE)
	select_tile(x, y)

func select_tile(x: int, y: int) -> void:
	tile_selector.select(x, y)

func get_contents_at(x: int, y: int) -> int:
	return tile_at[x][y]


func get_tower_at(x: int, y: int) -> WeakRef:
	if tile_at[x][y] != TILE_CONTENTS.TOWER:
		return null
	return tower_at[x][y]

#for building tower
func is_valid_tower_drop(x: int, y: int) -> bool:
	return tile_at[x][y] == TILE_CONTENTS.EMPTY

# for dropping items
func is_valid_item_drop(x: int, y: int) -> bool:
	return tile_at[x][y] == TILE_CONTENTS.TOWER

func build_tower(x: int, y: int, tower_type: String) -> bool:
	if tile_at[x][y] != TILE_CONTENTS.EMPTY:
		return false
	# warning-ignore:unsafe_method_access
	var tower : Tower = load(tower_type).instance()
	add_child(tower)
	tower.build_at(Vector2(x + 0.5, y + 0.5) * TILE_SIZE)
	tower_at[x][y] = weakref(tower)
	tile_at[x][y] = TILE_CONTENTS.TOWER
	return true

func drop_items(x: int, y: int, item_type: int) -> bool:
	if tile_at[x][y] != TILE_CONTENTS.TOWER:
		return false
	var tower : Tower = tower_at[x][y].get_ref()
	return tower.upgrade_with(item_type)

func dismantle_tower(x: int, y: int) -> bool:
	if tile_at[x][y] != TILE_CONTENTS.TOWER:
		return false
	var tower : Tower = tower_at[x][y].get_ref()
	var _items = tower.dismantle() # should handle queue free by itself
	# do smth with item
	tower_at[x][y] = null
	tile_at[x][y] = TILE_CONTENTS.EMPTY
	return true

func build_turret_at(x: int, y: int) -> void:
#	var turret = load($BuildUI.tower_to_be_built)
#	add_child(turret)
#	turret.position(Vector2(x,y) * TILE_SIZE)
	pass 
	
