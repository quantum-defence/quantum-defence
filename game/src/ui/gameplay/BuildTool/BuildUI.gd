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

var bag_item = preload("res://src/items/otherItems/Axe.tscn").instance()
var emerald_staff = preload("res://src/items/otherItems/EmeraldStaff.tscn").instance()
onready var all_inventories_slots = get_node("VBoxContainer/PanelContainer/PanelContainer/HBoxContainer/GridContainer")


var isRed = true
var redTile = preload("res://assets/img/UI/Cartoon GUI/PNG/Item Slot/Cartoon RPG UI_Slot - Grade S.png")
var blueTile = preload("res://assets/img/UI/Cartoon GUI/PNG/Item Slot/Cartoon RPG UI_Slot - Grade C.png")


#if buildMode is not true, then it is in normal mode
var buildMode : bool = false
var build_UI_items_held  = {
	"Slot1" : null,
	"Slot2" : null,
	"Slot3" : bag_item,
	"Slot4" : null,
	"Slot5" : null,
	"Slot6" : null,
	"Slot7" : emerald_staff,
	"Slot8" : null,
	"Slot9" : null,
	"Slot10" : bag_item
}



onready var tileSelector = find_parent("Map").get_node("Selector")
onready var currentMap = self.get_parent()



func _ready() -> void:
	get_tree().call_group("tower_builds", "change_visibility", false)
	# for slot in inventorySlots.get_children():
		# slot.connect("gui_input", self, "slot_gui_input", [slot])

	
func _on_BuildMode_pressed():
	print("buildMode pressed")
	get_tree().call_group("tower_builds", "change_visibility", true)
	
	var tower_inventory = get_parent().get_node("TowerInventory")
	if (tower_inventory.is_visible == true):
		tower_inventory.toggle_tower_inventory_visible()
	buildMode = true

func _on_InspectMode_pressed():
	print(buildMode)
	buildMode = false
	tileSelector.set_action(TileSelector.ACTION.INSPECTING, "smth")
	var tower_inventory = get_parent().get_node("TowerInventory")
	get_tree().call_group("tower_builds", "change_visibility", false)
	print(buildMode)


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

func _pick_up_item(item: Item) -> void:
	#Equip the item
	var slot
	for slots in build_UI_items_held:
		print(slots)
		if (build_UI_items_held[slots] == null):
			slot = slots
			build_UI_items_held[slots] = item
			break

	#Get reference to the slot that an item was eqipped to update texture
	print(slot)
	var current_slot = all_inventories_slots.get_node(slot).get_node("TextureRect")
	current_slot.texture = item.get_node("TextureRect").texture
	print(current_slot)		
	print(build_UI_items_held)		


func _on_TextureButton_pressed():
	print("Called")
	if (isRed):
		isRed = false
	else:
		isRed = true	


