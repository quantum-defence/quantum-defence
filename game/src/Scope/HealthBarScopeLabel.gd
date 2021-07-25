extends Label

var instructions = (
	"This is the health bar."
	+ "The red bar indicates the health of the red portal "
	+ "and the blue health indicates the health of the blue portal."
	+ "If any reaches zero, GAME OVER"
)


func _ready():
	self.text = instructions
