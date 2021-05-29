extends Node2D

var ItemClass = preload("res://src/items/core/Item.tscn")
var axeClass = preload("res://src/items/otherItems/Axe.tscn")

var item = null
var off_handitem = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if (randi() % 2 == 0):
		item = axeClass.instance() 
		add_child(item)
		

#Returns the item taken from the slot
#func pickFromSlot():
#	off_handitem = item
#	remove_child(item)
#	item = null
#	return off_handitem
#
##Doesnt return anything
#func putIntoSlot(newItem):
#	item = newItem
#	item.position = Vector2.ZERO
#	var tower_inventory_slot = find_parent("TowerInventory")
#	var UI_inventory_slot 
#	if (tower_inventory_slot == null):
#		UI_inventory_slot = find_parent("BuildUI")
#		if (UI_inventory_slot != null):
#			UI_inventory_slot.remove_child(item)
#	else: 
#		tower_inventory_slot.remove_child(item)
#	add_child(item)

func get_drag_data(position):
	var data = {}
	var drag_texture = Texture.new()
	drag_texture = self.texture
	drag_texture.rect_size = Vector2(100,100)


func can_drop_data(position, data):
	return true

func drop_data(position, data):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
