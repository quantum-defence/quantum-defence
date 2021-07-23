extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings_string = "res://src/ui/Menu/Settings.tscn"
var settings = preload("res://src/ui/Menu/Settings.tscn")
var setting_instance
var setting_present: bool = false
var isPaused = false
onready var arena = self.find_parent("Arena")
onready var pause_texture = preload("res://assets/img/UI/PausePlayButton/PauseButton.png")
onready var play_texture = preload("res://assets/img/UI/PausePlayButton/Play.png")

#Pause unpause node
func set_pause_node(node : Node, pause : bool) -> void:
	node.set_process(!pause)
	node.set_process_input(!pause)
	node.set_process_internal(!pause)
	node.set_process_unhandled_input(!pause)
	node.set_process_unhandled_key_input(!pause)
	node.set_physics_process(!pause)
	node.set_physics_process_internal(!pause)
	
#(Un)pauses a scene
#Ignored childs is an optional argument, that contains the path of nodes whose state must not be altered by the function
func set_pause_scene(rootNode : Node, pause : bool, ignoredChilds : PoolStringArray = [null]):
	set_pause_node(rootNode, pause)
	for node in rootNode.get_children():
		if not (String(node.get_path()) in ignoredChilds):
			set_pause_scene(node, pause, ignoredChilds)

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
				self.set_pause_scene(arena, true)
				self.set_pause_node(setting_instance, false)
				isPaused = true
			# Tbh dun really think the else statement below cos we cant access
			# When the scene itself is paused. Hence the paused statement in Settings.tscn
			elif setting_present:
				self.set_pause_scene(arena, false)
				isPaused = false

func _on_PauseButton_pressed():
	if (!isPaused):
		self.set_pause_scene(arena, true)
		self.set_pause_node($Control/PauseButton, false)
		isPaused = true
	else:
		self.set_pause_scene(arena, false)
		isPaused = false
