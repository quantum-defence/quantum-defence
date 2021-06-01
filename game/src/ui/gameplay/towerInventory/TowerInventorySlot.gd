extends TextureRect


var build_UI = get_parent()

func _process(delta):
	print(build_UI)

func get_drag_data(position): 
	var tower_inventory_name = get_parent().get_name()
	var tower_inventory_slot = self
	var tower_inventory = tower_inventory_slot.get_parent()
	
	var data = {}
	data["origin_texture"] = texture
	data["origin_panel"] = "BuildUI"
	data["origin_item"] = tower_inventory.tower_inventory_items_held[tower_inventory_name]
	data["origin_tower_inventory_slot_name"] = tower_inventory_name
	data["origin_tower_inventory_slot"] = tower_inventory_slot
	print(data)
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = texture
	drag_texture.rect_size = Vector2(100,100)
	drag_texture.process_priority = 1
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = - 0.5 * drag_texture.rect_size
	set_drag_preview(control)
	texture = null
	return data

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	var target_slot_name : String = get_parent().get_name()
	var target_slot = get_parent()
	var target_slot_item = build_UI.build_UI_items_held[target_slot_name]
	
	#Target slot is null 
	if (target_slot_item == null):
		#If target slot belongs to build UI. E.g just shifting within BuildUI
		if (target_slot.is_in_group("BuildUISlots")):
			data["target_item"] = null
			data["target_texture"] = null
			build_UI.build_UI_items_held[target_slot_name] = data["origin_item"]
			var origin_slot = data["origin_build_UI_slot_name"]
			build_UI.build_UI_items_held[origin_slot] = target_slot_item
			print("build_UI_target slot is null")
			print("Groups working well")
			texture = data["origin_texture"]
			
		#If target slot belongs to Tower inventory. E.g equipping item
		if (target_slot.is_in_group("TowerInventorySlots")):
			#Havent done yet for now 
			print("Go to tower inventorySlot")
			data["target_item"] = null
			data["target_texture"] = null
	
	#Swapping between items 
	else: 
		#If the item swap is within buildUI
		if (target_slot.is_in_group("BuildUISlots")):
			data["target_item"] = target_slot_item
			
			#Do the swap
			data["origin_build_UI_slot"].texture = target_slot.get_child(0).texture
			texture = data["origin_texture"]
			print("build_UI_target slot is not null")
	print(data)
	print(build_UI.build_UI_items_held)
	print("=====================================")
