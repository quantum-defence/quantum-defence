extends Node2D

const slotClass = preload("res://Panel.gd")
onready var inventorySlots = $TextureRect/GridContainer

var item_held  = null



func _ready():
	for slot in $TextureRect/GridContainer.get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])


func slot_gui_input(event:InputEvent, slot:slotClass):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("signal triggered and is left mouse presed")
			if item_held != null:
				if slot.item == null:
					slot.putIntoSlot(item_held)
					item_held = null
				else:
					var temp_item = slot.item
					slot.pickFromSlot()
					temp_item.global_position = event.global_position
					print("shud be following mouse now")
					slot.putIntoSlot(item_held)
					item_held = temp_item
			else:
				if slot.item != null:
					item_held = slot.pickFromSlot()
					item_held.global_position = get_global_mouse_position()
					print("shud be following mouse now")

var counter = 0
func _process(delta):
	counter += 1
	if (item_held != null and counter >= 60):
		counter = 0
		print(item_held)
		print(item_held.global_position)

func _input(event):
	if item_held != null:
		item_held.global_position = get_global_mouse_position()
