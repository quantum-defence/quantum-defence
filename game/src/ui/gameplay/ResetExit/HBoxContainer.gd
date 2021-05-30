extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	print("Reset button pressed")
	get_tree().change_scene("res://src/environment/map/Map.tscn")
	


func _on_ExitButton_pressed():
	print("Exit Button")
	get_tree().quit()
