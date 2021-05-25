extends Node2D

const slotClass = preload("res://Panel.gd")
onready var inventorySlots = $TextureRect/GridContainer

var holdingItem 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func slot_gui_input(event:InputEvent, slot:SlotClass):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.pressed:
			if holdingItem != null:
				if slot.item




func _input(event):
	if (holdingItem != null):
		holdingItem.global_position = get_global_mouse_position()
