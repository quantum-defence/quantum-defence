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


func _on_ResetButton_pressed():
	get_tree().get_root().get_node("Arena").set_up(null)
	


func _on_ExitButton_pressed():
	#get_tree().change_scene("res://src/ui/Menu/Menu.tscn")
	var menu = load("res://src/ui/Menu/Menu.tscn").instance()
	var arena = get_tree().get_root().get_node("Arena")
	var root = get_tree().get_root()
	root.add_child(menu)
	root.remove_child(arena)
	arena.queue_free()
