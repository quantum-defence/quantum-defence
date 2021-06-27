extends Node2D
class_name Arena

# DUPLICATE CODE: must also modify at tile selector
const TILE_SIZE = 64.0
enum TILE_CONTENTS { PATH, EMPTY, TOWER, HOME, INVALID = -1 }
enum ACTION { BUILDING, INSPECTING }

onready var tile_selector: TileSelector = $Selector
onready var level_map : LevelMap = $LevelMap
onready var tile_map : TileMap
onready var blue_home : Home
onready var red_home : Home
var tile_at
var tower_at

func _ready() -> void:
	var basic = load("res://src/environment/LevelMap/BasicLevel.tscn").instance()
	level_map.queue_free()
	self.add_child(basic)
	self.move_child(basic, 0)
	level_map = basic
	_set_up()
	$UI/Control/BuildUI.set_up()

func _set_up() -> void:
	tile_map = level_map.tile_skeleton
	blue_home = level_map.blue_home
	red_home = level_map.red_home
	tile_selector.set_action(ACTION.INSPECTING, "")
	tile_at = []
	tile_at.resize(90)
	for i in range(90):
		tile_at[i] = []
		tile_at[i].resize(90)
		for j in range(90):
			tile_at[i][j] = tile_map.get_cell(i, j)
	tile_at[red_home.position.x / TILE_SIZE][red_home.position.y / TILE_SIZE] = TILE_CONTENTS.HOME
	tile_at[blue_home.position.x / TILE_SIZE][blue_home.position.y / TILE_SIZE] = TILE_CONTENTS.HOME
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
	var build_UI = self.get_node("UI/Control/BuildUI")
	
	#Check and change the universe of the towers

	var animated_sprite = tower.get_node("AnimatedSprite")
	if (build_UI.isRed):
		animated_sprite.animation = "IdleRed(Level 1)"
		pass
	else:
		animated_sprite.animation = "IdleBlue(Level 1)"
		tower.isRed = false
	
	add_child(tower)
	tower.build_at(Vector2(x + 0.5, y) * TILE_SIZE)
	tower.z_index = tower.global_position.y / 10.0
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
