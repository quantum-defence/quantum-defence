extends AnimatedSprite

class_name Prompt

var counter = 0
const textArray: Array = [
	"Protect your portals! Red enemies attack through the red portals " \
	+ "and blue enemies attack through the blue portal.",
	"Enemy colour is set by the qubit " \
	+ "they contain, and each tower only hits enemies of the same colour.",
	"Add quantum items to the towers force an enemy into a colour" \
	+ "based on the quantum circuitry in the item.",
	"If it flips them into the " \
	+ "opposite colour, the enemy is forced to turn around and go to its new target, which lets you rack up more hits along its path.",
	"However, BEWARE that these quantum towers do not do any damage, and they only affect the qubit (colour) of the enemy.",
	"Hadamard (Orange) will put the enemy back into equal superposition before the weapon collapses it.",
	"A red tower equipped with Hadamard will turn on average 50% of the red enemies it hits to blue.",
	"RY item (Green) puts an enemy into a state of superposition that skews towards " \
	+ "collapsing into red: 87.5% chance of switching to red to be precise.",
	"The classical X gate (Blue) will simply flip the qubit 100% of the time, turning all enemies it hits into the opposite colour.",
	"Build towers to defend your portal! The cost of each tower is displayed on the right."
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
	self.play("Rolling")
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
	if self.animation == "Rolling":
		print("Comes here")
		ui.set_pause_scene(arena, true)
		ui.set_pause_scene(self, false)
		self.play("Static")


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
				self.queue_free()
				ui.set_pause_scene(scoping, false)
				scoping.visible = true
				var grey_out = ui.get_node("Control/GreyOut")
				grey_out.make_invis()
