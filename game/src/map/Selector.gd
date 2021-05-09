extends Area2D

const TILE_SIZE := 64.0

var _x : int
var _y : int

func selector(x : int, y : int) -> void:
	_x = x
	_y = y
	position = Vector2(x,y) * TILE_SIZE

func get_contents_at() -> void:
	get_parent().get_contents_at(_x, _y)
