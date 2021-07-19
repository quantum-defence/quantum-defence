extends AnimatedSprite

var counter = 0
const textArray: Array = [
	"Add quantum items to the towers \nto allow enemies to change \nbetween colors"
	, "Hadamard(Orange) gives a \n50 50 chance"
	, "RY item(Green) gives a \n12.5 87.5 chance"
	, "And the classical X gate(Blue)\n is a 0 100 chance"
	, "Enemies that change color\n are forced to walk to\n the new colors portal"
	, "This lengthens the time\n u can attack them"
	, "build towers to defend ur portal\n the gold of each \ntower is displayed at the top"]
	
	
onready var title = self.get_node("AllText/Title")
onready var text = self.get_node("AllText/Text")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Works")
	self.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
	self.play("Idle")

func _on_AnimatedSprite_animation_finished():
	if self.animation == "Idle":
		print("Comes here")
		self.play("Temp")

func _input(event: InputEvent):
	if (event is InputEventKey):
		if event.pressed:
			if counter > textArray.size() -1:
				self.queue_free()
			else :
				text.text =  textArray[counter]		
				counter += 1