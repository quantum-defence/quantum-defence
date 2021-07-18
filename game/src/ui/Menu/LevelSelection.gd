extends PopupMenu

var _levels: Array


func set_up(levels = []) -> void:
	clear()
	_levels = levels
	for level_id in range(levels.size()):
		add_item(levels[level_id].name, level_id)


func _on_LevelSelection_id_pressed(id: int) -> void:
	get_parent().start_level(_levels[id].src)

# TODO: Could refer to signal on hover to do levels[id].on_hover
