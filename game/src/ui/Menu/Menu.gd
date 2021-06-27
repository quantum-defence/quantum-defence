extends Control

const first_scene = preload("res://src/environment/map/Map.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var background_music = self.get_node("AudioStreamPlayer")
	background_music.playing = true
	pass # Replace with function body.



func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/environment/map/Map.tscn")