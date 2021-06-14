extends CanvasLayer

class_name TowerInventory

onready var inventorySlots = $TextureRect/GridContainer


#Tower to be built shud be an instance of tower. Each tower may have different items equipped
var tower_to_be_built : Tower =  preload("res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn").instance()
onready var tower_inventory_items_held
onready var build_ui = get_parent().get_node("BuildUI")

func _equip_item(slotNumber: String, item: Item ):
	tower_inventory_items_held[slotNumber] = item

func check_all_items_attributes():
	for slots in tower_to_be_built.tower_items_held.values():
		var temp_item_string = slots
	tower_inventory_items_held = tower_to_be_built.tower_items_held	

func change_tower_to_be_build(tower: Tower):
	tower_to_be_built = tower
	check_all_items_attributes()

	
#Function to make tower visible/invisible. Realised that 
# canvas layer has no property for visiblilty. Also, if i put it under
#node 2d, visiblitly still can press. So imma hack this shit and change the scale
# to 0.
func toggle_tower_inventory_visible():
	if (self.scale == Vector2(1,1)):
		self.scale = Vector2.ZERO
	else:
		self.scale = Vector2(1,1)	

		
func _ready():
	toggle_tower_inventory_visible()
	for slots in inventorySlots.get_children():
		slots.get_child(0).connect("gui_input", self, "slot_gui_input", [slots.get_child(0)])
	print("ready")	

func slot_gui_input(event: InputEvent, binds)-> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_RIGHT:
			print("aksjdbakjsdb")
			print(binds)
			var current_slot = binds
			var item_dropped = drop_item(current_slot)
			print("=========================")
			print(item_dropped)
			print("=========================")
			

func drop_item(slot):
	print(tower_to_be_built.tower_items_held)
	var slot_name = slot.get_parent().get_name()
	var item_dropped = tower_to_be_built._drop_item(slot_name)
	print(tower_to_be_built.tower_items_held)
	return item_dropped

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
