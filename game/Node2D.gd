extends Node2D

onready var label = $Label
var counter = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_pause_node(node : Node, pause : bool) -> void:
	node.set_process(!pause)
	node.set_process_input(!pause)
	node.set_process_internal(!pause)
	node.set_process_unhandled_input(!pause)
	node.set_process_unhandled_key_input(!pause)
	node.set_physics_process(!pause)
	
#(Un)pauses a single node
func set_pause_scene(rootNode : Node, pause : bool, ignoredChilds : PoolStringArray):
	set_pause_node(rootNode, pause)
	for node in rootNode.get_children():
		if not (String(node.get_path()) in ignoredChilds):
			set_pause_scene(node, pause, ignoredChilds)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func incr():
	counter += 1
	label.text = str(counter)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	incr()

func _input(event: InputEvent):
	if event is InputEventKey:
		if event.is_pressed() and event.is_action_pressed("Settings"):
			print("pressed")
			set_pause_scene(self, true, [])
		
