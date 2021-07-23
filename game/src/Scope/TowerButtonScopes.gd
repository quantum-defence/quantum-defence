extends Label

var instructions = "These are the tower buttons\n. " \
	+ "Click here\n to choose the tower built\n " \
	+ "Currently only the first tower is available\n" \
	+ "Alternatively you can press Q on ur keyboard"

func _ready():
	self.text = instructions
