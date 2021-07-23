extends Label

var instructions = "These are the items. Items dropped by enemies\n " \
	+ "can be clicked on and will appear here\n" \
	+ "Open a tower inventory by clicking on a tower\n" \
	+ "and equip an item by dragging and dropping"

func _ready():
	self.text = instructions
	
