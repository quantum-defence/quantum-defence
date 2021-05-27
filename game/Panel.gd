extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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
func pickFromSlot():
	off_handitem = item
	remove_child(item)
	item = null
	return off_handitem

#Doesnt return anything
func putIntoSlot(newItem):
	item = newItem
	item.position = Vector2.ZERO
	var inventorySlot = find_parent("TowerInventory")
	inventorySlot.remove_child(item)
	add_child(item)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
