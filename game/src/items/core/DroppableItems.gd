extends Area2D

#Idea is for the items to drop in map
#Therefore shud be the child of map

onready var build_UI = get_parent().get_node("UI").get_node("Control").get_node("BuildUI")
onready var item = get_node("Item")

#func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx:int):
#	print("Before click")
#	if (event.is_pressed() and event.button_index == BUTTON_LEFT):
#		print("Comes here")
#		build_UI._pick_up_item(item)
#		queue_free()

func _input(event):
	if (event.is_pressed() and event.button_index == BUTTON_LEFT):
		var state := get_world_2d().direct_space_state
		for col in state.intersect_point(get_global_mouse_position(), 32, [], 0x7FFFFFFF, false, true):
			if col.collider == self:
				print(event)
