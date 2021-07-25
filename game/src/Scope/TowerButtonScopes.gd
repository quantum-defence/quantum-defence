extends Label

var instructions = (
	"These are the tower buttons. "
	+ "Click here to choose the tower built. "
	+ "Currently only the first tower is available. "
	+ "Alternatively you can press 1 on your keyboard"
)


func _ready():
	self.text = instructions
