extends Node2D


export var init_red_portal_health: int = 100
export var init_blue_portal_health: int = 100
onready var red_portal_health: int = init_red_portal_health
onready var blue_portal_health: int = init_blue_portal_health
var red_health_display: TextureProgress
var blue_health_display: TextureProgress

func _ready():
	red_health_display = self.get_node("Red")
	blue_health_display = self.get_node("Blue")
	red_health_display.set_max(init_red_portal_health)
	blue_health_display.set_max(init_blue_portal_health)
	update_health()
	
func _set_red_portal_health(health: int):
	red_portal_health = health
	update_health()
	
func _change_red_portal_health(health_change: int):
	red_portal_health += health_change
	update_health()
		
func _set_blue_portal_health(health: int):
	blue_portal_health = health
	update_health()
	
func _change_blue_portal_health(health_change: int):
	blue_portal_health += health_change
	update_health()
	
func update_health():
	#Update the health bar texture
	red_health_display.value = red_portal_health
	blue_health_display.value = blue_portal_health
	
	#Update the label of the health bar
	var red_health_label = red_health_display.get_node("Label")
	var blue_health_label = blue_health_display.get_node("Label")
	red_health_label.set_text("Health   " + str(red_portal_health))
	blue_health_label.set_text("Health   " + str(blue_portal_health))

func _make_visible():
	self.visible = true

func _make_invis():
	self.visible = false

func _toggle_invis():
	if(self.visible):
		_make_invis()
	else:
		_make_visible()

func _input(event: InputEvent):
	if event is InputEventKey:
		if event.is_pressed() and event.is_action_pressed("Toggle_health_bar"):
			_toggle_invis()
