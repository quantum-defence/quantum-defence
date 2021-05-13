extends Node2D

const TILE_SIZE = 64.0
enum tile_content {ROAD, EMPTY_PLOT, TURRET, BASE, INVALID}

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var x = event.position.x / TILE_SIZE
			var y = event.position.y / TILE_SIZE
			$Selector.select(x, y)

func get_contents_at(x: int, y : int) -> void:
	# Check for turrets
	# Check for path
	return


#for item drops
func is_valid_turret_drop(x: int, y: int) -> bool:
	# for now all values return true
	return true

func build_turret_at(x: int, y: int) -> void:
	# var turret = preload(...).instance()
	# add_child(turret)
	# turret.position(Vector2(x,y) * TILE_SIZE)
	return
