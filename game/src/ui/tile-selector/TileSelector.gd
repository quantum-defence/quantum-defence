extends Area2D
class_name TileSelector

const TILE_SIZE := 128.0

var _x : int
var _y : int

func select(x : int, y : int) -> void:
	_x = x
	_y = y
	position = Vector2(x,y) * TILE_SIZE

func get_contents_at() -> void:
	get_parent().get_contents_at(_x, _y)
