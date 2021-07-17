extends "res://src/ui/gameplay/towerInventory/TowerInventorySlot.gd"


#Override can drop data function
func can_drop_data(position, data):
	var item = data["origin_item"]
	return item != null and item.isTensor


func update_tower_quantum_circuit():
	pass
