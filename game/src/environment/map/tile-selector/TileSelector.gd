extends Area2D
class_name TileSelector

# DUPLICATE CODE: must also modify at map
const TILE_SIZE = 64.0
enum TILE_CONTENTS { PATH, EMPTY, TOWER, HOME, INVALID = -1 }
enum ACTION { BUILDING, INSPECTING }

var _x : int
var _y : int
var _action : int
var _type : String # resource to instance from
var _valid_tile : bool

onready var arena : Arena = get_parent()

func select(x : int, y : int) -> void:
	_x = x
	_y = y
	position = Vector2(x,y) * TILE_SIZE

# if action == ACTION.BUILDING, type must be of Tower.TYPE
# likewise if action == ACTION.DROPPING, type must be of Item.TYPE
func set_action(action : int, type_resource_string : String) -> void:
	_action = action
	_type = type_resource_string

func _process(_delta: float) -> void:
	self.modulate = Color(0, 1, 0) if _is_valid_tile() else Color(1, 0, 0)
	
func _is_valid_tile() -> bool:
	var tile = arena.get_contents_at(_x, _y)
	match (_action):
		ACTION.BUILDING:
			return tile == TILE_CONTENTS.EMPTY
		ACTION.INSPECTING:
			return tile == TILE_CONTENTS.TOWER
		_: # INSPECTING
			return true

func take_action():
	if !_is_valid_tile():
		return null
	match (_action):
		ACTION.BUILDING:
			return arena.build_tower(_x, _y, _type)
		ACTION.INSPECTING:
			return arena.tower_at[_x][_y].get_ref()
		_: # INSPECTING
			# idk maybe show a pop up for towers to inspect?
			return 0
