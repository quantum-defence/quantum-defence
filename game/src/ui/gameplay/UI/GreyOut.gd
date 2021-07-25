extends CanvasLayer


func make_visible():
	self.scale = Vector2.ONE


func make_invis():
	self.scale = Vector2.ZERO

func can_drop_data(position, data):
	return false
	
func drop_data(position, data):
	print("item dropped here")
	data["target_slot"] = data["origin_slot"]
	data["target_item"] = data["origin_item"]
	data["origin_slot"].texture = data["origin_texture"]