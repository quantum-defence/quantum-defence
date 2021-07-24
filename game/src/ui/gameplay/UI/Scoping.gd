extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _prev():
	if (counter == 0):
		pass
	else:
		var child = self.get_child(counter)
		var prev_child = self.get_child(counter - 1)
		child.visible = false
		prev_child.visible = true
		counter -= 1

func next():
	if (counter < self.get_child_count() -1):
		var child = self.get_child(counter)
		var next_child = self.get_child(counter + 1)
		child.visible = false
		next_child.visible = true
		counter += 1
	else:
		self.queue_free()
		
func _input(event: InputEvent):
	if event is InputEventKey:
		if event.pressed and event.is_action_pressed("back_key"):
			_prev()
		elif event.pressed and ! event.is_action_pressed("Settings") and ! event.is_action_pressed("back_key"):
			next()
