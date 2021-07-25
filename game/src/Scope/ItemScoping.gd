extends Label

var instructions = (
	"These are the item slots. Click on the items dropped by enemies to have them appear hear. " \
	+ "Open a tower inventory by clicking on a tower "
	+ "and equip an item by dragging and dropping into the tower slot"
)


func _ready():
	self.text = instructions
