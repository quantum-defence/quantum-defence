extends Control
	# data["origin_texture"] = texture
	# data["origin_panel"] = "BuildUI"
	# data["origin_item"] = build_UI.build_UI_items_held[build_UI_slot_name]
	# data["origin_slot_name"] = build_UI_slot_name
	# data["origin_slot"] = build_UI_slot

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	data["target_slot"] = data["origin_slot"]
	data["target_item"] = data["origin_item"]
	data["origin_slot"].texture = data["origin_texture"]

func _on_Control_gui_input(event):
	get_viewport().set_meta("ignore_input", true)
