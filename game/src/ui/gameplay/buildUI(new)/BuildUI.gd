extends CanvasLayer
class_name BuildUI

#Have yet to add angel tower
enum TOWERTYPES {
	OBELISK = 0,
	FLYINGOBELISK = 1, 
	LIGHTNINGTOTEM = 2, 
	DEMONSTATUE = 3,
	MOONTOWER = 4,
	EYETOWER = 5
}

#Preload all the tower scenes to build
const RESOURCE = ["res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn",
"res://src/environment/towers/pixelTowers/flyingObelisk/flyingObelisk.tscn",
"res://src/environment/towers/pixelTowers/lightningTotem/LightningTotem.tscn",
"res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn",
"res://src/environment/towers/pixelTowers/moonTower/MoonTower.tscn",
"res://src/environment/towers/pixelTowers/eyeTower/EyeTower.tscn"]

#if buildMode is not true, then it is in normal mode
var buildMode : bool = false

onready var tileSelector = find_parent("Map").get_node("Selector")
var item_held


#reference to the map that its on
onready var currentMap = self.get_parent()

# Called when the node enters the scene tree for the first time.

func _on_BuildMode_pressed():
	print("buildMode pressed")
	buildMode = true

func _on_InspectMode_pressed():
	print(buildMode)
	buildMode = false
	print(buildMode)

				
#	if (isPlacing): 
#		var t := Transform2D.IDENTITY
#		t.origin = get_global_mouse_position()
#		var colliding = test_move(t, Vector2.ZERO)
#		position = t.origin
#		modulate = Color.red if colliding else Color.yellow
#		modulate.a = 0.75 
#		if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
#			isPlacing = false 
#	else:
#		modulate = Color.white

func _on_ObeliskTower_pressed():
	print("ObeliskTowerSelected")
	if (buildMode):
		print("Called tile selector in UI")
		tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.OBELISK])
	pass


func _on_FlyingObelisk_pressed():
	print("FlyingObeliskTowerSelected")
	if (buildMode):
		tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.FLYINGOBELISK])
	pass # Replace with function body.


func _on_LightningTotem_pressed():
	print("LightningTotem Selected")
	if (buildMode):
		tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.LIGHTNINGTOTEM])
	pass # Replace with function body.


func _on_DemonStatue_pressed():
	print("DemonStatue selected")
	if (buildMode):
		tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.DEMONSTATUE])
	pass # Replace with function body.


func _on_MoonTower_pressed():
	print("MoonTower selected")
	if (buildMode):
		tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.MOONTOWER])
	pass # Replace with function body.


func _on_EyeTower_pressed():
	print("EyeTower selected")
	if (buildMode):
		tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.EYETOWER])
	pass # Replace with function body.

const slotClass = preload("res://src/ui/gameplay/buildUI(new)/Panel.gd")
onready var inventorySlots = $VBoxContainer/PanelContainer/PanelContainer/HBoxContainer/GridContainer


func _ready():
	for slot in inventorySlots.get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])


#func slot_gui_input(event:InputEvent, slot:slotClass):
#	if (event is InputEventMouseButton):
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			print("signal triggered and is left mouse presed")\
#			#Does the swapping for the item 
#			if item_held != null:
#				if slot.item == null:
#					slot.putIntoSlot(item_held)
#					item_held = null
#				else:
#					var temp_item = slot.item
#					slot.pickFromSlot()
#					temp_item.global_position = event.global_position
#					print("shud be following mouse now")
#					slot.putIntoSlot(item_held)
#					item_held = temp_item
#			else:
#				if slot.item != null:
#					item_held = slot.pickFromSlot()
#					print("shud be following mouse now")
