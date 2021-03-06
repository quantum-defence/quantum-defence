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

# godot appears to conflict with gdformat (line break after 'preload(' )
const one = "res://assets/img/towers/pixelTowers/FlyingObelisk_Full_v2/FlyingObelisk_no_lightnings_no_letter(Red).png"
const two = "res://assets/img/towers/pixelTowers/BloodMoonTower_full_version/RedMoonTower_free_idle_animation..png"
const three = "res://assets/img/towers/pixelTowers/FlyingObelisk_Full_v2/FlyingObelisk_no_lightnings_no_letter.png"
const four = "res://assets/img/towers/pixelTowers/BloodMoonTower_full_version/RedMoonTower_free_idle_animation(Blue).png"

var redSprites: Array = [
	preload("res://assets/img/towers/pixelTowers/Obelisk_Full_version/Obelisk(Red Level 1).png"),
	preload(one),
	preload("res://assets/img/towers/pixelTowers/LightningTotemFull/Totem_full-Sheet(Red).png"),
	preload("res://assets/img/towers/pixelTowers/Demon_Statue/Demon_Statue_red_sheet.png"),
	preload(two),
	preload("res://assets/img/towers/pixelTowers/LoRTower_Full/EyeTower(Red Level 1).png")
]

var blueSprites: Array = [
	preload("res://assets/img/towers/pixelTowers/Obelisk_Full_version/Obelisk(Blue Level 1).png"),
	preload(three),
	preload("res://assets/img/towers/pixelTowers/LightningTotemFull/Totem_full-Sheet.png"),
	preload("res://assets/img/towers/pixelTowers/Demon_Statue/Demon_Statue_blue_sheet.png"),
	preload(four),
	preload("res://assets/img/towers/pixelTowers/LoRTower_Full/EyeTower(Blue Level 1).png")
]

#Preload all the tower scenes to build
const RESOURCE: Array = [
	"res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn",
	"res://src/environment/towers/pixelTowers/flyingObelisk/flyingObelisk.tscn",
	"res://src/environment/towers/pixelTowers/lightningTotem/LightningTotem.tscn",
	"res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn",
	"res://src/environment/towers/pixelTowers/moonTower/MoonTower.tscn",
	"res://src/environment/towers/pixelTowers/eyeTower/EyeTower.tscn"
]

var hbox_prefix = "VBoxContainer/PanelContainer/PanelContainer/MarginContainer/HBoxContainer/"
onready var all_inventories_slots = get_node(hbox_prefix + "ItemSlots")
onready var gold_label = self.get_node(hbox_prefix + "Gold/Label")
var tower_following_mouse
export var gold_for_stage: int = 100

var h_gate = preload("res://src/items/QuantumItems/H.tscn")
var ry_gate = preload("res://src/items/QuantumItems/RY.tscn")
var x_gate = preload("res://src/items/QuantumItems/X.tscn")

var bag_item = preload("res://src/items/otherItems/Axe.tscn")
var emerald_staff = preload("res://src/items/otherItems/EmeraldStaff.tscn")
var tile_size = 64
var is_visible = true

var isRed = true

# godot appears to conflict with gdformat (line break after 'preload(' )
const r_src = "res://assets/img/UI/Cartoon GUI/PNG/Item Slot/Cartoon RPG UI_Slot - Grade S.png"
const b_src = "res://assets/img/UI/Cartoon GUI/PNG/Item Slot/Cartoon RPG UI_Slot - Grade C.png"
var redTile = preload(r_src)
var blueTile = preload(b_src)

#if build_mode is not true, then it is in normal mode
var build_mode: bool = false
var build_UI_items_held: Dictionary = {
	"Slot1": null,
	"Slot2": null,
	"Slot3": null,
	"Slot4": null,
	"Slot5": null,
	"Slot6": null,
	"Slot7": null,
	"Slot8": null,
	"Slot9": null,
	"Slot10": null
}


func update_slot(slot_name: String, item = null):
	if slot_name != "":
		build_UI_items_held[slot_name] = item


onready var tileSelector: TileSelector = find_parent("Arena").get_node("Selector")
# TODO: change below to Arena, or delete if not necessary (best practice: minimise calls to parent)


func _input(event):
	if Input.is_action_just_pressed("build_first_tower"):
		_on_ObeliskTower_pressed()
	elif Input.is_action_just_pressed("build_second_tower"):
		_on_FlyingObelisk_pressed()
	elif Input.is_action_just_pressed("build_third_tower"):
		_on_LightningTotem_pressed()
	elif Input.is_action_just_pressed("build_forth_tower"):
		_on_DemonStatue_pressed()
	elif Input.is_action_just_pressed("build_fifth_tower"):
		_on_MoonTower_pressed()
	elif Input.is_action_just_pressed("build_sixth_tower"):
		_on_EyeTower_pressed()
	elif Input.is_action_just_pressed("change_color"):
		#This function refers to pressing the button to change the color of the towers
		var button = self.get_node(
			"VBoxContainer/PanelContainer/PanelContainer/MarginContainer/HBoxContainer/ColourSwitcher"
		)
		button.pressed = ! button.pressed
		_toggle_build_sprites_colors()
	return


func _ready() -> void:
	get_tree().call_group("tower_builds", "change_visibility", true)
	tileSelector.set_action(TileSelector.ACTION.INSPECTING, "smth")


func set_up(gold_start: int) -> void:
	var initial_items = self.find_parent("Arena").level_map.initial_items
	build_UI_items_held = {
		"Slot1": null,
		"Slot2": null,
		"Slot3": null,
		"Slot4": null,
		"Slot5": null,
		"Slot6": null,
		"Slot7": null,
		"Slot8": null,
		"Slot9": null,
		"Slot10": null
	}
	for item_name in initial_items:
		var item = null
		match item_name:
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
	gold_label.reset()
	self.set_gold(gold_start)


func _on_BuildMode_pressed():
	get_tree().call_group("tower_builds", "change_visibility", true)

	var tower_inventory = get_parent().get_node("TowerInventory")
	if tower_inventory.is_visible == true:
		tower_inventory.toggle_tower_inventory_visible()
	build_mode = true


func _on_InspectMode_pressed():
	build_mode = false
	tileSelector.set_action(TileSelector.ACTION.INSPECTING, "smth")
	var tower_inventory = get_parent().get_node("TowerInventory")
	get_tree().call_group("tower_builds", "change_visibility", false)


func _helper_mouse_tower(tower_type: int) -> void:
	if is_visible:
		make_buildUI_invisible()
	# Make the instance of the tower always follow the mouse
	tower_following_mouse = load(RESOURCE[tower_type]).instance()
	tower_following_mouse.toggle_range_visible()
	if tileSelector.get_node("Tower") == null:
		tileSelector.add_child(tower_following_mouse)
		tower_following_mouse.position = Vector2(
			tower_following_mouse.position.x + tile_size / 2,
			tower_following_mouse.position.y + tile_size
		)
		tower_following_mouse.set_name("Tower")
	else:
		var temp = tileSelector.get_node("Tower")
		tileSelector.remove_child(temp)
		temp.queue_free()
		tileSelector.add_child(tower_following_mouse)
		tower_following_mouse.position = Vector2(
			tower_following_mouse.position.x + tile_size / 2,
			tower_following_mouse.position.y + tile_size
		)
		tower_following_mouse.set_name("Tower")


func _build_tower(tower_type: int) -> void:
	build_mode = true
	tileSelector.set_action(TileSelector.ACTION.BUILDING, RESOURCE[tower_type])
	_helper_mouse_tower(tower_type)


func _on_ObeliskTower_pressed():
	_build_tower(TOWERTYPES.OBELISK)


func _on_FlyingObelisk_pressed():
	_build_tower(TOWERTYPES.FLYINGOBELISK)


func _on_LightningTotem_pressed():
	_build_tower(TOWERTYPES.LIGHTNINGTOTEM)


func _on_DemonStatue_pressed():
	_build_tower(TOWERTYPES.DEMONSTATUE)


func _on_MoonTower_pressed():
	_build_tower(TOWERTYPES.MOONTOWER)


func _on_EyeTower_pressed():
	_build_tower(TOWERTYPES.EYETOWER)


func _pick_up_item(item: Item) -> void:
	#Equip the item
	var slot
	for slots in build_UI_items_held:
		if build_UI_items_held[slots] == null:
			slot = slots
			build_UI_items_held[slots] = item
			break

	#Get reference to the slot that an item was eqipped to update texture
	var current_slot = all_inventories_slots.get_node(slot).get_node("TextureRect")
	current_slot.texture = item.get_node("TextureRect").texture


func _toggle_build_sprites_colors():
	isRed = not isRed
	var sceneTree = get_tree()
	var towers: Array = sceneTree.get_nodes_in_group("tower_builds")
	var temp = 0
	var sprite_used: Array = redSprites if isRed else blueSprites

	for towerIndex in range(towers.size()):
		var picture = sprite_used[towerIndex]
		towers[towerIndex].get_node("Sprite").texture = picture


func make_buildUI_visible():
	self.scale = Vector2(1, 1)
	self.get_parent().get_node("GreyOut").make_visible()
	is_visible = true


func make_buildUI_invisible():
	self.scale = Vector2.ZERO
	self.get_parent().get_node("GreyOut").make_invis()
	is_visible = false


func can_drop_data(position, data):
	return true


func drop_data(position, data):
	data["target_slot"] = data["origin_slot"]
	data["target_item"] = data["origin_item"]
	data["origin_slot"].texture = data["origin_texture"]


func change_gold(gold_added: int) -> bool:
	return gold_label.change_gold(gold_added)


func set_gold(gold_set: int) -> bool:
	return gold_label.set_gold(gold_set)
