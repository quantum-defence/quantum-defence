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

var redSprites : Array = [
	preload("res://assets/img/towers/pixelTowers/Obelisk_Full_version/Obelisk(Red Level 1).png"),
	preload("res://assets/img/towers/pixelTowers/FlyingObelisk_Full_v2/FlyingObelisk_no_lightnings_no_letter(Red).png"),
	preload("res://assets/img/towers/pixelTowers/LightningTotemFull/Totem_full-Sheet(Red).png"),
	preload("res://assets/img/towers/pixelTowers/Demon_Statue/Demon_Statue_red_sheet.png"),
	preload("res://assets/img/towers/pixelTowers/BloodMoonTower_full_version/RedMoonTower_free_idle_animation..png"),
	preload("res://assets/img/towers/pixelTowers/LoRTower_Full/EyeTower(Red Level 1).png")
]

var blueSprites : Array = [
	preload("res://assets/img/towers/pixelTowers/Obelisk_Full_version/Obelisk(Blue Level 1).png"),
	preload("res://assets/img/towers/pixelTowers/FlyingObelisk_Full_v2/FlyingObelisk_no_lightnings_no_letter.png"),
	preload("res://assets/img/towers/pixelTowers/LightningTotemFull/Totem_full-Sheet.png"),
	preload("res://assets/img/towers/pixelTowers/Demon_Statue/Demon_Statue_blue_sheet.png"),
	preload("res://assets/img/towers/pixelTowers/BloodMoonTower_full_version/RedMoonTower_free_idle_animation(Blue).png"),
	preload("res://assets/img/towers/pixelTowers/LoRTower_Full/EyeTower(Blue Level 1).png")
]

#Preload all the tower scenes to build
const RESOURCE : Array = [
	"res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn",
	"res://src/environment/towers/pixelTowers/flyingObelisk/flyingObelisk.tscn",
	"res://src/environment/towers/pixelTowers/lightningTotem/LightningTotem.tscn",
	"res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn",
	"res://src/environment/towers/pixelTowers/moonTower/MoonTower.tscn",
	"res://src/environment/towers/pixelTowers/eyeTower/EyeTower.tscn"
]
onready var all_inventories_slots = get_node("VBoxContainer/PanelContainer/PanelContainer/MarginContainer/HBoxContainer/ItemSlots")

onready var tower_following_mouse 
onready var mouse_pos

var h_gate = preload("res://src/items/QuantumItems/H.tscn")
var ry_gate = preload("res://src/items/QuantumItems/RY.tscn")
var x_gate = preload("res://src/items/QuantumItems/X.tscn")

var bag_item = preload("res://src/items/otherItems/Axe.tscn")
var emerald_staff = preload("res://src/items/otherItems/EmeraldStaff.tscn")

var isRed = true
var redTile = preload("res://assets/img/UI/Cartoon GUI/PNG/Item Slot/Cartoon RPG UI_Slot - Grade S.png")
var blueTile = preload("res://assets/img/UI/Cartoon GUI/PNG/Item Slot/Cartoon RPG UI_Slot - Grade C.png")


#if buildMode is not true, then it is in normal mode
var buildMode : bool = false
var build_UI_items_held : Dictionary = {
	"Slot1" : null,
	"Slot2" : null,
	"Slot3" : null,
	"Slot4" : null,
	"Slot5" : null,
	"Slot6" : null,
	"Slot7" : null,
	"Slot8" : null,
	"Slot9" : null,
	"Slot10" : null
}



onready var tileSelector: TileSelector = find_parent("Arena").get_node("Selector")
# TODO: change below to Arena, or delete if not necessary (best practice: minimise calls to parent)



func _ready() -> void:
	get_tree().call_group("tower_builds", "change_visibility", true)
	tileSelector.set_action(TileSelector.ACTION.INSPECTING, "smth")

func set_up() -> void:
	var initial_items = self.find_parent("Arena").level_map.initial_items
	build_UI_items_held =  {
		"Slot1" : null,
		"Slot2" : null,
		"Slot3" : null,
		"Slot4" : null,
		"Slot5" : null,
		"Slot6" : null,
		"Slot7" : null,
		"Slot8" : null,
		"Slot9" : null,
		"Slot10" : null
	}
	for item_name in initial_items:
		var item = null
		match(item_name):
			'h':
				item = h_gate.instance()
			'x':
				item = x_gate.instance()
			'ry':
				item = ry_gate.instance()
			'bag_item':
				item = bag_item.instance()
			'emerald_staff':
				item = emerald_staff.instance()
			_:
				item = null
		if item != null:
			_pick_up_item(item)

func _on_BuildMode_pressed():
	get_tree().call_group("tower_builds", "change_visibility", true)
	
	var tower_inventory = get_parent().get_node("TowerInventory")
	if (tower_inventory.is_visible == true):
		tower_inventory.toggle_tower_inventory_visible()
	buildMode = true

func _on_InspectMode_pressed():
	buildMode = false
	tileSelector.set_action(TileSelector.ACTION.INSPECTING, "smth")
	var tower_inventory = get_parent().get_node("TowerInventory")
	get_tree().call_group("tower_builds", "change_visibility", false)

func _on_ObeliskTower_pressed():
	buildMode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.OBELISK])

	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[TOWERTYPES.OBELISK]).instance()
	self.find_parent("Arena").add_child(tower_following_mouse)
	pass


func _on_FlyingObelisk_pressed():
	buildMode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.FLYINGOBELISK])

	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[TOWERTYPES.FLYINGOBELISK]).instance()
	self.find_parent("Arena").add_child(tower_following_mouse)
	pass # Replace with function body.


func _on_LightningTotem_pressed():
	buildMode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.LIGHTNINGTOTEM])

	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[TOWERTYPES.LIGHTNINGTOTEM]).instance()
	self.find_parent("Arena").add_child(tower_following_mouse)
	pass # Replace with function body.


func _on_DemonStatue_pressed():
	buildMode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.DEMONSTATUE])

	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[TOWERTYPES.DEMONSTATUE]).instance()
	self.find_parent("Arena").add_child(tower_following_mouse)
	pass # Replace with function body.


func _on_MoonTower_pressed():
	buildMode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.MOONTOWER])

	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[TOWERTYPES.MOONTOWER]).instance()
	self.find_parent("Arena").add_child(tower_following_mouse)
	pass # Replace with function body.


func _on_EyeTower_pressed():
	buildMode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[TOWERTYPES.EYETOWER])

	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[TOWERTYPES.EYETOWER]).instance()
	self.find_parent("Arena").add_child(tower_following_mouse)
	pass # Replace with function body.

func _pick_up_item(item: Item) -> void:
	#Equip the item
	var slot
	for slots in build_UI_items_held:
		if (build_UI_items_held[slots] == null):
			slot = slots
			build_UI_items_held[slots] = item
			break

	#Get reference to the slot that an item was eqipped to update texture
	var current_slot = all_inventories_slots.get_node(slot).get_node("TextureRect")
	current_slot.texture = item.get_node("TextureRect").texture


func _on_TextureButton_pressed():
	isRed = not isRed
	_toggle_build_sprites_colors()


func _toggle_build_sprites_colors():
	var sceneTree = get_tree()
	var towers: Array = sceneTree.get_nodes_in_group("tower_builds")
	var temp = 0
	var sprite_used: Array = redSprites if isRed else blueSprites

	for towerIndex in range(towers.size()):
		var picture = sprite_used[towerIndex]
		towers[towerIndex].get_node("Sprite").texture = picture
