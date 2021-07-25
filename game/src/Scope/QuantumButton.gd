extends Label

var instructions = (
	"This is the quantum button. "
	+ "Click here to swap between colour"
	+ "of towers built. Remember that red towers"
	+ "can only hit red enemies and vice versa."
	+ "Alternatively you can press Q on your keyboard"
)


func _ready():
	self.text = instructions
