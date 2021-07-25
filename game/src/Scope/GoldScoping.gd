extends Label

var instructions = (
	"This is the gold you have: "
	+ "Killing enemies drop gold and "
	+ "building towers cost gold. "
	+ "Thats all for now. Have fun!"
)


func _ready():
	self.text = instructions
