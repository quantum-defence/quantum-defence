extends "res://src/ui/gameplay/towerInventory/TowerInventorySlot.gd"

#Override can drop data function
func can_drop_data(position, data):
	print("Can drop data is being called")
	var item = data["origin_item"]
	if (item.isTensor == true):
		return true
	else: 
		return false	



