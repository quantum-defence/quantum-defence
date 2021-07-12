extends CanvasLayer

class_name TowerInventory

onready var inventorySlots = $TextureRect/GridContainer
onready var quantumSlots = $TextureRect/QuantumLabel/QuantumCircuit

#Tower to be built shud be an instance of tower. Each tower may have different items equipped
var is_visible = false
var tower_to_be_built : Tower =  preload("res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn").instance()
onready var tower_inventory_items_held : Dictionary
onready var build_ui = get_parent().get_node("BuildUI")
var tower_display_reference = Vector2(1690,275)
onready var prob_bar = self.get_node("TextureRect/ProbabiilityBar")

#Remove all children nodes	
func delete_children(node):
	for n in node.get_children():
			node.remove_child(n)
			n.queue_free()

func update_tower(slot_name : String = "", item = null):

	if slot_name != "":
		tower_inventory_items_held[slot_name] = item;

	#Update all the tower items
	tower_to_be_built.update_items(slot_name, item)
	
	#Update probability bar
	var prob: Dictionary = tower_to_be_built.probs
	var prob_of_red = prob["0"]
	prob_bar.update_prob(prob_of_red)
	
#Update tower inventory textures. To be called when change tower to be build is called	
func update_tower_inventory_textures():
	for slots in inventorySlots.get_children():
		var slots_name = slots.get_name()
		var slot_texture_rects = slots.get_node("TextureRect")
		var current_item = tower_to_be_built.tower_items_held[slots_name]

		#Reset all the textures
		slot_texture_rects.texture = null

		#If any items in the new tower inspected, update all the textures
		if (current_item != null):
			slot_texture_rects.texture = current_item.get_node("TextureRect").texture
			
	for slots in quantumSlots.get_children():
		var slots_name = slots.get_name()
		var slot_texture_rects = slots.get_node("TextureRect")
		var current_item = tower_to_be_built.tower_items_held[slots_name]

		#Reset all the textures
		slot_texture_rects.texture = null

		#If any items in the new tower inspected, update all the textures
		if (current_item != null):
			slot_texture_rects.texture = current_item.get_node("TextureRect").texture	

func change_tower_to_be_build(tower: Tower):
	if tower == tower_to_be_built:
		return
	if tower == null:
		tower = null
		make_tower_inventory_invisible()
		return
	tower_to_be_built = tower
	tower_inventory_items_held = tower_to_be_built.tower_items_held
	print(tower_inventory_items_held)
	var temp = tower_inventory_items_held.duplicate()
	tower_inventory_items_held = temp
	print(tower_inventory_items_held.duplicate())

	var animated_sprite = tower_to_be_built.get_node("AnimatedSprite")
	animated_sprite.z_index = 1
	var other_animated_sprite = animated_sprite.duplicate()	
	other_animated_sprite.position = Vector2.ZERO
	var control = self.get_node("TextureRect/Control")

	var tower_display = self.get_node("TextureRect/TowerDisplay")
	update_tower()
	delete_children(tower_display)
	tower_display.add_child(other_animated_sprite)
	update_tower_inventory_textures()


	
#Function to make tower visible/invisible. Realised that 
# canvas layer has no property for visiblilty. Also, if i put it under
#node 2d, visiblitly still can press. So imma hack this shit and change the scale
# to 0.
func toggle_tower_inventory_visible():
	if (self.scale == Vector2(1,1)):
		self.scale = Vector2.ZERO
		is_visible = false
	else:
		self.scale = Vector2(1,1)	
		is_visible = true

func make_tower_inventory_visible():
	self.scale = Vector2(1,1)
	is_visible = true		

func make_tower_inventory_invisible():
	self.scale = Vector2.ZERO
	is_visible = false
	
func _ready():
	toggle_tower_inventory_visible()
	for slots in inventorySlots.get_children():
		slots.get_child(0).connect("gui_input", self, "slot_gui_input", [slots.get_child(0)])

func slot_gui_input(event: InputEvent, binds)-> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_RIGHT:
			# print(binds)
			var current_slot = binds
			var item_dropped = drop_item(current_slot)
			# print("=========================")
			# print(item_dropped)
			# print("=========================")
			build_ui._pick_up_item(item_dropped)
			

func drop_item(slot: TowerInventorySlot) -> Item:
	var slot_name = slot.get_parent().get_name()
	var item_dropped = tower_to_be_built._drop_item(slot_name)
	# print(tower_to_be_built.tower_items_held)
	slot.texture = null
	return item_dropped

func _on_DismissButton_pressed() -> void:
	change_tower_to_be_build(null)

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
