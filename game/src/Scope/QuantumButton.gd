extends Label

var instructions = (
	"This is the quantum button. "
	+ "Click here\n to swap between color"
	+ "of towers built.\n Remember that red towers"
	+ "can only \n hit red enemies and vice versa\n"
	+ "Alternatively you can press Q on your keyboard"
)


func _ready():
	self.text = instructions
