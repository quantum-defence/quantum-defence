extends CanvasLayer

class_name TowerInventory

const slotClass = preload("res://src/ui/gameplay/buildUI(new)/Panel.gd")
onready var inventorySlots = $TextureRect/GridContainer

var item_held  = null
var items_equiped = {}
var tower_to_be_built : Tower

var bag_item = "res://src/items/otherItems/Axe.tscn"
var emerald_staff = "res://src/items/otherItems/EmeraldStaff.tscn"

var tower_inventory_items_held  = {
	"Slot1" : bag_item,
	"Slot2" : null,
	"Slot3" : null,
	"Slot4" : bag_item
}

var item_total
func _equip_item(slotNumber: String, item: Item ):
	tower_inventory_items_held[slotNumber] = item
	
	
#func _ready():
#	for slot in $TextureRect/GridContainer.get_children():
#		slot.connect("gui_input", self, "slot_gui_input", [slot])


#func slot_gui_input(event:InputEvent, slot:slotClass):
#	if (event is InputEventMouseButton):
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			print("signal triggered and is left mouse presed")
#			if item_held != null:
#				if slot.item == null:
#					slot.putIntoSlot(item_held)
#					item_held = null
#				else:
#					var temp_item = slot.item
#					slot.pickFromSlot()
#					temp_item.global_position = event.global_position
#					print("shud be following mouse now")
#					slot.putIntoSlot(item_held)
#					item_held = temp_item
#			else:
#				if slot.item != null:
#					item_held = slot.pickFromSlot()
#					item_held.global_position = get_global_mouse_position()
#					print("shud be following mouse now")


