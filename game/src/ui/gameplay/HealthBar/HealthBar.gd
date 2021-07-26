extends Node2D

export var max_portal_health: int = 100
onready var red_portal_health: int = 0
onready var blue_portal_health: int = 0
var red_health_display: TextureProgress
var blue_health_display: TextureProgress


func _ready():
	red_health_display = self.get_node("Red")
	blue_health_display = self.get_node("Blue")
	set_max_portal_health(max_portal_health)
	_update_health()


func set_max_portal_health(health: int):
	max_portal_health = health
	red_health_display.set_max(max_portal_health)
	blue_health_display.set_max(max_portal_health)
	_update_health()


func set_portal_health(health: int, isRed: bool):
	if isRed:
		red_portal_health = int(max(health, 0))
	else:
		blue_portal_health = int(max(health, 0))
	_update_health()


func _update_health():
	#Update the health bar texture
	if red_health_display == null or blue_health_display == null:
		return
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
	if self.visible:
		_make_invis()
	else:
		_make_visible()


func _input(event: InputEvent):
	if event is InputEventKey:
		if event.is_pressed() and event.is_action_pressed("Toggle_health_bar"):
			_toggle_invis()
