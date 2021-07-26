extends Node2D
class_name Arena

# DUPLICATE CODE: must also modify at tile selector
const TILE_SIZE = 64.0
enum TILE_CONTENTS { PATH, EMPTY, TOWER, PORTAL, INVALID = -1 }
enum ACTION { BUILDING, INSPECTING }

onready var tile_selector: TileSelector = $Selector
onready var level_map: LevelMap = $LevelMap
onready var tile_map: TileMap
var blue_portal
var red_portal
var tile_at
var tower_at
var current_level_class = null


func set_up(level) -> void:
	if level_map != null:
		level_map.queue_free()
	if tower_at != null and tower_at.size() > 0:
		for i in range(90):
			var arr = tower_at[i]
			tower_at[i] = []
			for maybe_tower in arr:
				if maybe_tower != null and typeof(maybe_tower) != TYPE_INT:
					maybe_tower.get_ref().queue_free()
	if level == null:
		level = current_level_class
		$UI/Control.reset()
	current_level_class = level
	level = level.instance()
	self.add_child(level)
	self.move_child(level, 0)
	level_map = level

	tile_map = level_map.tile_skeleton
	blue_portal = level_map.blue_portal
	red_portal = level_map.red_portal
	tile_selector.set_action(ACTION.INSPECTING, "")
	tile_at = []
	tile_at.resize(90)
	for i in range(90):
		tile_at[i] = []
		tile_at[i].resize(90)
		for j in range(90):
			tile_at[i][j] = tile_map.get_cell(i, j)
	tile_at[red_portal.position.x / TILE_SIZE][red_portal.position.y / TILE_SIZE] = TILE_CONTENTS.PORTAL
	tile_at[blue_portal.position.x / TILE_SIZE][blue_portal.position.y / TILE_SIZE] = TILE_CONTENTS.PORTAL
	tower_at = []
	tower_at.resize(90)
	for i in range(90):
		tower_at[i] = []
		tower_at[i].resize(90)
		for j in range(90):
			tower_at[i][j] = tile_map.get_cell(i, j)

	level_map.set_up()
	$UI/Control/BuildUI.set_up(level_map.gold_start)
	for tower_init in level_map.prebuilt_towers:
		self.build_tower(tower_init.x, tower_init.y, tower_init.tower_res_string, tower_init.colour)
	level_map.connect("on_game_end", self, "on_game_end")


func on_game_end(
	is_win: bool,
	blue_health: float,
	red_health: float,
	cycle_number: int,
	enemy_spawn_count: int,
	enemy_kill_count: int
):
	var dict = {
		"result": "won" if is_win else "lost",
		"blue_health": int(max(blue_health, 0)),
		"red_health": int(max(red_health, 0)),
		"current_cycle": cycle_number + 1,
		"enemy_spawn_count": enemy_spawn_count,
		"enemy_kill_count": enemy_kill_count
	}
	var gameCompleteDialog: WindowDialog = $GameCompleteDialog
	var text = (
		"You {result} on round {current_cycle} \n\n"
		+ "{enemy_spawn_count} enemies spawned \n"
		+ "{enemy_kill_count} enemies killed \n"
		+ "Red: {red_health}\nBlue: {blue_health}"
	)
	gameCompleteDialog.set_text(text.format(dict))
	gameCompleteDialog.popup_centered()


# dummy function to show use of selector
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var e: InputEventMouseButton = event
		if e.button_index == BUTTON_LEFT and e.pressed:
			tile_selector.take_action()
	elif event is InputEventMouseMotion:
		var e: InputEventMouseMotion = event
		select_using_position(e.position)


func select_using_position(relative_to_map: Vector2) -> void:
	var x = floor(relative_to_map.x / TILE_SIZE)
	var y = floor(relative_to_map.y / TILE_SIZE)
	select_tile(x, y)


func select_tile(x: int, y: int) -> void:
	tile_selector.select(x, y)


func get_contents_at(x: int, y: int) -> int:
	return tile_at[x][y]


func get_tower_at(x: int, y: int) -> WeakRef:
	if tile_at[x][y] != TILE_CONTENTS.TOWER:
		return null
	return tower_at[x][y]


#for building tower
func is_valid_tower_drop(x: int, y: int) -> bool:
	return tile_at[x][y] == TILE_CONTENTS.EMPTY


# for dropping items
func is_valid_item_drop(x: int, y: int) -> bool:
	return tile_at[x][y] == TILE_CONTENTS.TOWER


func build_tower(x: int, y: int, tower_type: String, force_colour = "") -> bool:
	if tile_at[x][y] != TILE_CONTENTS.EMPTY:
		return false
	# warning-ignore:unsafe_method_access
	var tower: Tower = load(tower_type).instance()
	var animated_sprite = tower.get_node("AnimatedSprite")

	var build_isRed = self.get_node("UI/Control/BuildUI").isRed
	if force_colour == "red":
		build_isRed = true
	elif force_colour == "blue":
		build_isRed = false

	animated_sprite.animation = "IdleRed(Level 1)" if build_isRed else "IdleBlue(Level 1)"
	tower.isRed = build_isRed

	add_child(tower)
	tower.build_at(Vector2(x + 0.5, y) * TILE_SIZE)
	tower.z_index = tower.global_position.y / 10.0
	tower_at[x][y] = weakref(tower)
	tile_at[x][y] = TILE_CONTENTS.TOWER

	#Make tower start firing
	tower.is_frozen = false
	return true


func drop_items(x: int, y: int, item_type: int) -> bool:
	if tile_at[x][y] != TILE_CONTENTS.TOWER:
		return false
	var tower: Tower = tower_at[x][y].get_ref()
	return tower.upgrade_with(item_type)


func dismantle_tower(x: int, y: int) -> bool:
	if tile_at[x][y] != TILE_CONTENTS.TOWER:
		return false
	var tower: Tower = tower_at[x][y].get_ref()
	var _items = tower.dismantle()  # should handle queue free by itself
	# do smth with item
	tower_at[x][y] = null
	tile_at[x][y] = TILE_CONTENTS.EMPTY
	return true
