extends "res://src/ui/gameplay/towerInventory/TowerInventorySlot.gd"

#Override can drop data function
func can_drop_data(position, data):
	var item = data["origin_item"]
	if (item.isTensor == true):
		return true
	else: 
		return false

func drop_data(position, data):
	var target_slot_name : String = get_parent().get_name()
	var target_slot = get_parent()
	var target_slot_item = tower_inventory.tower_inventory_items_held[target_slot_name]
	
	var origin_slot_name = data["origin_slot_name"]
	var origin_slot = data["origin_slot"].get_parent()
	var origin_slot_item = data["origin_item"]

	#Target slot is null 
	if (target_slot_item == null):
		#If target slot belongs to build UI. E.g just shifting within BuildUI
		if (origin_slot.is_in_group("BuildUISlots")):
			data["target_item"] = null
			data["target_texture"] = null
			tower_inventory.tower_inventory_items_held[target_slot_name] = data["origin_item"]
			build_UI.build_UI_items_held[origin_slot_name] = null
			texture = data["origin_texture"]
			
		#If target slot belongs to Tower inventory. E.g equipping item
		elif (origin_slot.is_in_group("TowerInventorySlots")):
			data["target_item"] = null
			data["target_texture"] = null
			tower_inventory.tower_inventory_items_held[target_slot_name] = data["origin_item"]
			tower_inventory.tower_inventory_items_held[origin_slot_name] = null
			texture = data["origin_texture"]
		
	#Swapping between items 
	else: 
		#If the item swap is within buildUI
		if (origin_slot.is_in_group("BuildUISlots")):
			data["target_item"] = target_slot_item
			
			#Swap for textures
			data["origin_slot"].texture = target_slot.get_child(0).texture
			texture = data["origin_texture"]
			
			#Swap for actual info
			var temp_item_for_swap = target_slot_item
			tower_inventory.tower_inventory_items_held[target_slot_name] = origin_slot_item
			build_UI.build_UI_items_held[origin_slot_name] = temp_item_for_swap

		elif (target_slot.is_in_group("TowerInventorySlots")):
			data["target_item"] = target_slot_item
			
			#Swap for textures
			data["origin_slot"].texture = target_slot.get_child(0).texture
			texture = data["origin_texture"]

			#Swap for actual info
			var temp_item_for_swap = target_slot_item
			tower_inventory.tower_inventory_items_held[target_slot_name] = origin_slot_item
			tower_inventory.tower_inventory_items_held[origin_slot_name] = temp_item_for_swap
	tower_inventory.update_tower()

func update_tower_quantum_circuit():
		pass
