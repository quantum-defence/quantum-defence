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
	get_tree().change_scene("res://src/ui/gameplay/Arena/Arena.tscn")


func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Tutorial_pressed():
	pass # Replace with function body.
