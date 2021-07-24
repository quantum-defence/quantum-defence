extends AnimatedSprite

class_name prompt

var counter = 0
const textArray: Array = [
	"Protect your portals!\n Red enemies go to red portal\nand blue enemies go\nto blue portal. Each tower\ncan only hit enemies \nof the same color",
	"Add quantum items to the towers \nto allow enemies to change \nbetween colors",
	"Hadamard(Orange) gives a \n50/50 chance",
	"RY item(Green) gives a \n12.5/87.5 chance",
	"And the classical X gate(Blue)\n is a 0/100 chance",
	"Enemies that change color\n are forced to walk to\n the new colors portal",
	"This lengthens the time\n you can attack them",
	"Build towers to defend your portal\n the gold of each \ntower is displayed at the top",
	"However BEWARE Quantum towers\n do not do any damage!, they only\n change the color of enemies"
]

onready var title = self.get_node("AllText/Title")
onready var text = self.get_node("AllText/Text")
onready var arena = self.find_parent("Arena")
onready var ui = arena.get_node("UI")
onready var scoping = ui.get_node("Control/Scoping")
onready var page_number = self.get_node("AllText/Page")


# Called when the node enters the scene tree for the first time.
func _ready():
	# Used to pause the game
	print("Works")
	self.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
	self.play("Idle")
	text.text = textArray[counter]


func _next() -> bool:
	if counter < textArray.size() - 1:
		counter += 1
		text.text = textArray[counter]
		page_number.text = str(counter + 1)
		return true
	else:
		return false


func _prev():
	if counter == 0:
		return false
	else:
		counter -= 1
		text.text = textArray[counter]
		page_number.text = str(counter + 1)


func _on_AnimatedSprite_animation_finished():
	if self.animation == "Idle":
		print("Comes here")
		ui.set_pause_scene(arena, true)
		ui.set_pause_scene(self, false)
		self.play("Temp")


func _input(event: InputEvent):
	if event is InputEventKey:
		#Go back 
		if event.pressed and event.is_action_pressed("back_key"):
			print("Reaches here")
			print(counter)
			if ! _prev():
				pass
		#Go forward
		if (
			event.pressed
			and ! event.is_action_pressed("Settings")
			and ! event.is_action_pressed("back_key")
		):
			if ! _next():
				ui.set_pause_scene(arena, false)
				self.queue_free()
				scoping.visible = true
				ui.set_pause_scene(scoping, false)
