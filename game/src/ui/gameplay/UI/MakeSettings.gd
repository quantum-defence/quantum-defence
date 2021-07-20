extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var settings = preload("res://src/ui/Menu/Settings.tscn")
var setting_instance
var setting_present: bool = false


func _input(event: InputEvent):
	if event is InputEventKey:
		if event.is_pressed() and event.is_action_pressed("Settings"):
			#Shud add a pause for the game here
			if ! setting_present:
				setting_instance = settings.instance()
				setting_instance._toggle_origin()
				self.add_child(setting_instance)
				setting_instance._toggle_reset_exit()
				setting_present = true
			else:
				setting_instance.queue_free()
				setting_present = false
