extends CenterContainer

class_name LevelContainer

var _level_id: int


func set_up(level_id: int, level_name: String, level_description: String) -> void:
	$VBox/Name.text = level_name
	$VBox/Description.text = level_description
	_level_id = level_id


func _on_PlayButton_pressed() -> void:
	self.find_parent("LevelSelection").on_play_pressed(_level_id)
