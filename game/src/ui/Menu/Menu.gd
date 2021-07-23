extends Control

const levels_info: Array = [
	{
		"name": "Tutorial",
		"src": "res://src/environment/LevelMap/Tutorial/Tutorial.tscn",
		"description": "Learn how to play with a slow paced start."
	},
	{
		"name": "Level One",
		"src": "res://src/environment/LevelMap/L1/L1_main.tscn",
		"description": "Border incursions..."
	},
	{
		"name": "Level Two",
		"src": "res://src/environment/LevelMap/L2/L2_main.tscn",
		"description": "Two ways in, no way out."
	},
	{
		"name": "Level Three",
		"src": "res://src/environment/LevelMap/L3/L3_main.tscn",
		"description": "A bit of a twist."
	},
	{
		"name": "Unused - A",
		"src": "res://src/environment/LevelMap/L1-2/L1-2_main.tscn",
		"description": "Make your stand"
	},
	{
		"name": "Unused - B",
		"src": "res://src/environment/LevelMap/L1-3/L1-3_main.tscn",
		"description": "Make your stand"
	},
]


func _on_PlayButton_pressed():
	var level_selector = _free_self_start_new("res://src/ui/Menu/LevelSelection.tscn")
	level_selector.set_up(levels_info)
	return


# Called by the pop up menu
func start_level(level_src: String):
	var arena = _free_self_start_new("res://src/ui/gameplay/Arena/Arena.tscn")
	var level = load(level_src)
	arena.set_up(level)


func _on_Settings_pressed() -> void:
	_free_self_start_new("res://src/ui/Menu/Settings.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Credits_pressed() -> void:
	_free_self_start_new("res://src/ui/Menu/Credits.tscn")


func _free_self_start_new(resource_path: String):
	var loaded = load(resource_path).instance()
	var root = get_tree().get_root()
	root.add_child(loaded)
	root.remove_child(self)
	self.queue_free()
	return loaded
