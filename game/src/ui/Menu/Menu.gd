extends Control


func _on_PlayButton_pressed():
	var levels = [
		{ 
			"name": "Level 1",
			"src": "res://src/environment/LevelMap/L1-1/L1-1_main.tscn", 
			# "on_hover": Could have description / picture pop up 
		},
		{ 
			"name": "Level 2", 
			"src": "res://src/environment/LevelMap/L1-2/L1-2_main.tscn", 
		},
		{ 
			"name": "Level 3", 
			"src": "res://src/environment/LevelMap/L1-3/L1-3_main.tscn", 
		},
		{ 
			"name": "Level 4", 
			"src": "res://src/environment/LevelMap/L1-4/L1-4_main.tscn", 
		},
	]
	$LevelSelection.set_up(levels)
	$LevelSelection.popup_centered()
	return


func _on_Tutorial_pressed():
	var tutorials = [
		# tutorial 1 to show typical TD
		# tutorial 2 to drag and drop items
		{ 
			"name": "Tutorial 1", # All together
			"src": "res://src/environment/LevelMap/Tutorial/Tutorial.tscn", 
			# "on_hover": Could have description / picture pop up 
		},
	]
	$LevelSelection.set_up(tutorials)
	$LevelSelection.popup_centered()
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
