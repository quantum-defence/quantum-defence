extends HBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isVisible = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_make_invis()
	pass  # Replace with function body.


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


func _make_visible():
	print("make vis")
	self.rect_scale = Vector2(0.5, 0.5)
	isVisible = true


func _make_invis():
	self.rect_scale = Vector2.ZERO
	isVisible = false


func _toggle_invis():
	if isVisible:
		_make_invis()
	else:
		_make_visible()
