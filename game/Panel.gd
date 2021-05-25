extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ItemClass = preload("res://src/items/core/Item.tscn")
var item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if (randi() % 2 == 0):
		item = ItemClass.instance()
		add_child(item)
		

func pickFromSlot():
	remove_child(item)
	find_parent("TowerInventory").add_child(item)
	item = null

func putIntoSlot(newItem):
	item = newItem
	item.position = Vector2.ZERO
	var inventorySlot = find_parent("TowerInventory")
	inventorySlot.remove_child(item)
	add_child(item)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
