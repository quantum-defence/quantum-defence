extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func can_drop_data(position, data):
	return true

func drop_data(position, data):
	print("Comes to UI")
	data["target_slot"] = data["origin_slot"]
	data["target_item"] = data["origin_item"]
	data["origin_slot"].texture = data["origin_texture"]
