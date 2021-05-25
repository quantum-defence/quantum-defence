extends KinematicBody2D
class_name Tower

# var firing_interval := 0.2


var ItemClass = preload("res://src/items/core/Item.tscn")
onready var _target : Enemy = null
onready var _enemiesInRange := []
onready var _timer : Timer = $Timer
onready var itemsHeld = []
var weapon 



func _ready() -> void:
	#_timer.set_wait_time(firing_interval)
	_timer.connect("timeout", self, "_fire")

func _fire() -> void:
	weapon = preload("res://src/projectile/core/Projectile.tscn").instance()
	var axe = preload("res://src/items/otherItems/Axe.tscn")
	self._equip_item(axe.instance())
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

func _physics_process(delta) -> void:
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
		#Check for all the stats
		if (item.damageIncrease != 0):
			weapon.damage = towerDamage + item.damageIncrease
		if (item.attackSpeedIncrease != 0):
			var newTowerAttackSpeed = towerAttackSpeed * 100/(100 + item.attackSpeedIncrease)
			$Timer.set_wait_time(newTowerAttackSpeed)
		if (item.rangeIncrease != 0):
			$Range/RangeRadius.set_radius(rangeRadius + item.rangeIncrease)
		if (item.projectileSpeed != 0):
			weapon.speed += item.projectileSpeed
