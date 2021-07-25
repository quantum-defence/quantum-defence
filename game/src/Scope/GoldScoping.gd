extends Label

var instructions = (
	"This is the gold you have:"
	+ "Killing enemies drop gold and"
	+ "Build towers cost gold."
	+ "Thats all for now. Have Fun!"
)


func _ready():
	self.text = instructions
