extends Label

var instructions = "This is the health bar" \
	+ "The red bar indicates the health\n of the red portal " \
	+ "And the blue health\n indicates the health of the blue portal\n" \
	+ "If any reaches zero, GAMEOVER"

func _ready():
	self.text = instructions
