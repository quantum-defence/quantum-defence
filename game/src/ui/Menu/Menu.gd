extends Control

onready var background_music = self.get_node("AudioStreamPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	background_music.playing = true
	pass # Replace with function body.

func _process(delta):
	if (background_music.playing == false):
		background_music.playing = true

func _on_PlayButton_pressed():
	var arena = load("res://src/ui/gameplay/Arena/Arena.tscn").instance()
	var basic = load("res://src/environment/LevelMap/BasicLevel.tscn").instance()
	var root = get_tree().get_root()
	root.add_child(arena)
	arena.set_up(basic)
	
	root.remove_child(self)
	self.queue_free()

func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Tutorial_pressed():
	var arena = load("res://src/ui/gameplay/Arena/Arena.tscn").instance()
	var basic = load("res://src/environment/LevelMap/BasicLevel.tscn").instance()
	var root = get_tree().get_root()
	root.add_child(arena)
	arena.set_up(basic)
	
	root.remove_child(self)
	self.queue_free()
