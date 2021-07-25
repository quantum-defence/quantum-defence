extends Area2D
class_name TileSelector

# DUPLICATE CODE: must also modify at map
const TILE_SIZE = 64.0
enum TILE_CONTENTS { PATH, EMPTY, TOWER, PORTAL, INVALID = -1 }
enum ACTION { BUILDING, INSPECTING, IDLE }

var _x: int
var _y: int
var _action: int
var _type: String  # resource to instance from
var _valid_tile: bool

# TODO: Remove all arena / parent references, convert to signals
onready var arena = get_parent()
onready var build_ui = arena.get_node("UI/Control/BuildUI")


func select(x: int, y: int) -> void:
	_x = x
	_y = y
	position = Vector2(x, y) * TILE_SIZE


# if action == ACTION.BUILDING, type must be of Tower.TYPE
# likewise if action == ACTION.DROPPING, type must be of Item.TYPE
func set_action(action: int, type_resource_string: String) -> void:
	_action = action
	_type = type_resource_string


func _process(_delta: float) -> void:
	var mouse_tower = self.get_node("Tower")
	if mouse_tower == null:
		self.modulate = Color(0, 1, 0) if _is_valid_tile() else Color(1, 0, 0)
	else:
		if _is_valid_tile():
			mouse_tower.modulate = Color(1, 0.1, 0, 1) if build_ui.isRed else Color(0, 0.7, 1, 1)
			self.modulate = Color(1, 0.1, 0, 0.5) if build_ui.isRed else Color(0, 0.7, 1, 0.8)
		else:
			# is not valid tile		
			mouse_tower.modulate = Color(0, 0, 0, 1)
			self.modulate = Color(0, 0, 0, 1)


func _is_valid_tile() -> bool:
	var tile = arena.get_contents_at(_x, _y)

	#If the person clicks on a tower, it always must inspect it first
	if tile == TILE_CONTENTS.TOWER:
		self.set_action(self.ACTION.INSPECTING, "inspecting")
		var mouse_tower = self.get_node("Tower")
		if mouse_tower != null:
			mouse_tower.queue_free()
		build_ui.tower_following_mouse = null
		return true

	#After u press a button build mode becomes true
	elif build_ui.build_mode == true:
		if tile == TILE_CONTENTS.TOWER:
			return false
		elif tile == TILE_CONTENTS.EMPTY:
			return true

	#If button is not pressed yet		
	if tile == TILE_CONTENTS.PATH:
		return false
	elif tile == TILE_CONTENTS.EMPTY:
		self.set_action(self.ACTION.IDLE, "Idle")
		return true
	return true


func take_action():
	if ! _is_valid_tile():
		return null

	var tower_inventory = arena.get_node("UI/Control/TowerInventory")
	match _action:
		ACTION.BUILDING:
			var mouse_tower = self.get_node("Tower")
			var tower_cost = mouse_tower.gold_cost
			var negative_tower_cost = tower_cost * -1
			mouse_tower.queue_free()

			build_ui.tower_following_mouse = null
			var enough_gold = build_ui.change_gold(negative_tower_cost)

			build_ui.make_buildUI_visible()
			if ! enough_gold:
				var show_rejection = arena.get_node("UI/Control/GoldIndicator")
				show_rejection._make_visible()
				show_rejection.get_node("Timer").start()

			else:
				arena.build_tower(_x, _y, _type)

			self.set_action(self.ACTION.IDLE, "Idle")
		ACTION.INSPECTING:
			if arena.get_tower_at(_x, _y) == null:
				return 0
			var inspected_tower = arena.get_tower_at(_x, _y).get_ref()
			if inspected_tower == null:
				return 0
			else:
				if tower_inventory.tower_to_be_built == inspected_tower:
					tower_inventory.toggle_tower_inventory_visible()
				else:
					tower_inventory.make_tower_inventory_visible()
				tower_inventory.change_tower_to_be_build(inspected_tower)
				return 0
		ACTION.IDLE:
			tower_inventory.make_tower_inventory_invisible()
			return 0
		_:
			assert(false, 'Should not reach here')
			return 0
