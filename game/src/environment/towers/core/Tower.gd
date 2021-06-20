extends KinematicBody2D
class_name Tower

enum TYPES { 
	FASTEST = 0,
	REPEATER = 1, 
	SHOTGUN = 2, 
	ULTIMATE = 3,
}

const RESOURCE = [
	'res://src/environment/towers/FastestTower.tscn',
	'res://src/environment/towers/RepeaterTower.tscn',
	'res://src/environment/towers/ShotgunTower.tscn',
	'res://src/environment/towers/UltimateTower.tscn'
]

var bag_item = preload("res://src/items/otherItems/Axe.tscn").instance()
var emerald_staff = preload("res://src/items/otherItems/EmeraldStaff.tscn").instance()

var tower_items_held  = {
	"Slot1" : bag_item,
	"Slot2" : null,
	"Slot3" : null,
	"Slot4" : bag_item
}

onready var _target : Enemy = null
onready var _enemiesInRange := []
onready var _timer : Timer = $Timer
onready var itemsHeld = []
var weapon 
onready var _attributes := [0, 0, 0, 0] # assuming 4 attributes

func _ready() -> void:
	#_timer.set_wait_time(firing_interval)
# warning-ignore:return_value_discarded
	_timer.connect("timeout", self, "_fire")

func build_at(position: Vector2) -> void:
	self.position = position
	# _play_build_tower_animation()
	# show animation

func dismantle() -> Array:
	# show animation
	var attr = self._attributes
	queue_free()
	return attr

func upgrade_with(item_type: int) -> bool:
	# Item.TYPES should be an enum that handles this
	var current_level = self._attributes[item_type]
	if current_level < 5:
		self._attributes[item_type] = current_level + 1
		return true
	return false
	

func _fire() -> void:
	weapon = preload("res://src/projectile/core/Projectile.tscn").instance()
	weapon.fire(global_position, _target)
	get_parent().add_child(weapon)


func _choose_enemy() -> Enemy:
	# may have future considerations based on quantum state
	if _enemiesInRange.size() == 0:
		return null
	
	var chosen_enemy : Enemy = _enemiesInRange[0]
	var min_dist := self.position.distance_squared_to(chosen_enemy.position)
	for enemy in _enemiesInRange:
		if enemy.action == Enemy.ACTION.DIE:
			_forget_out_of_range(enemy)
		var new_dist := self.position.distance_squared_to(enemy.position)
		if min_dist > new_dist:
			chosen_enemy = enemy
	return chosen_enemy

func _process(delta: float) -> void:
	_target = _choose_enemy()
	if (_target != null and _timer.is_stopped()):
		_timer.start()
		_fire()

func _add_new_in_range(enemy: Enemy) -> void:
	_enemiesInRange.append(enemy)
	
func _forget_out_of_range(enemy: Enemy) -> void:
	_enemiesInRange.erase(enemy)

func _on_Range_body_entered(body) -> void:
	if body is Enemy:
		_add_new_in_range(body)

func _on_Range_body_exited(body: Node) -> void:
	if body is Enemy:
		_forget_out_of_range(body)

func _equip_item(item):
	# All the current stats of the tower
	var rangeRadius = $Range/RangeRadius.shape.radius
	var towerDamage = weapon.damage
	var projectileSpeed = weapon.speed
	var towerAttackSpeed = $Timer.get_wait_time()
	print(towerAttackSpeed)
	
	if (itemsHeld.size() < 4):
		itemsHeld.append(item)
		print("item is appended")
		print(weapon.speed)
		#Check for all the stats
		if (item.damageIncrease != 0):
			weapon.damage = towerDamage + item.damageIncrease
		if (item.attackSpeedIncrease != 0):
			var newTowerAttackSpeed = towerAttackSpeed * 100/(100 + item.attackSpeedIncrease)
			$Timer.set_wait_time(newTowerAttackSpeed)
		if (item.rangeIncrease != 0):
			$Range/RangeRadius.set_radius(rangeRadius + item.rangeIncrease)


#func _play_build_tower_animation():
#	$BuildAnimation.visible = true
#	$BuildAnimation.play("Build", false)
#	# $BuildAnimation.visible = false
#	pass

func _drop_item(slot:String):
	var temp = tower_items_held[slot]
	tower_items_held[slot] = null
	return temp
