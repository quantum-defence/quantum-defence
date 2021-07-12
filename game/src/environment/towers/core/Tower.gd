extends KinematicBody2D
class_name Tower

# Special variable (only thing not reset by _reset())
var tower_items_held = {
	"Slot1": null,
	"Slot2": null,
	"Slot3": null,
	"Slot4": null,
	"QuantumSlot1": null,
	"QuantumSlot2": null,
	"QuantumSlot3": null,
	"QuantumSlot4": null,
	"QuantumSlot5": null,
}

onready var _target: Enemy = null

onready var weapon = preload("res://src/projectile/core/Projectile.tscn")
onready var _enemiesInRange := []
onready var _timer: Timer = $Timer
onready var itemsHeld: Array = []
onready var tensorItems: Array = []
onready var qn: QuantumNode = $QuantumNode

# Attributes
export var range_radius = 528
export var tower_damage = 20
export var projectile_speed = 600
export var tower_attack_speed = 1.0
export var is_frozen = true  # unfrozen by build_tower() in Arena.gd

var probs: Dictionary
var is_tensor := false

export var isRed := true


func _ready() -> void:
	_reset()
	# warning-ignore:return_value_discarded
	_timer.connect("timeout", self, "_fire")


func _reset() -> void:
	# Resets everything and is_tensor except tower_items_held (dictionary)
	itemsHeld = []
	tensorItems = []
	itemsHeld.resize(4)
	tensorItems.resize(5)
	is_tensor = false

	$Range/RangeRadius.shape.radius = range_radius
	var weapon_instance = weapon.instance()
	weapon_instance.damage
	projectile_speed = weapon_instance.speed
	weapon_instance.queue_free()
	_timer.set_wait_time(tower_attack_speed)

	self.qn.qc = QuantumCircuit.new()
	self.qn.qc.set_circuit(1, 1)
	probs = {"0": 0, "1": 1} if isRed else {"0": 1, "1": 0}


func build_at(position: Vector2) -> void:
	self.position = position
	# _play_build_tower_animation()
	# show animation


func dismantle():
	# show animation
	queue_free()
	return


func _fire():
	if is_frozen:
		return null
	var weapon_instance = weapon.instance()
	weapon_instance.damage = tower_damage
	weapon_instance.speed = projectile_speed
	weapon_instance.fire(global_position, _target)
	get_parent().add_child(weapon_instance)
	if is_tensor:
		weapon_instance.set_prob(probs)
		_forget_enemy(_target)

	return weapon_instance


func _choose_enemy() -> Enemy:
	# may have future considerations based on quantum state
	if _enemiesInRange.size() == 0:
		return null

	var chosen_enemy: Enemy = null
	var min_dist := 999999999999
	for enemy in _enemiesInRange:
		if enemy.action == Enemy.ACTION.DIE:
			_forget_enemy(enemy)
		if enemy.qubit_state == (1 if self.isRed else 2):
			var new_dist := self.position.distance_squared_to(enemy.position)
			if min_dist > new_dist:
				chosen_enemy = enemy
	if chosen_enemy == null or (chosen_enemy.qubit_state != (1 if self.isRed else 2)):
		return null
	return chosen_enemy


func _process(delta: float) -> void:
	_target = _choose_enemy()
	if _target != null and _timer.is_stopped():
		_timer.start()
		_fire()


func _add_enemy(enemy: Enemy) -> void:
	_enemiesInRange.append(enemy)


func _forget_enemy(enemy: Enemy) -> void:
	_enemiesInRange.erase(enemy)


func _on_Range_body_entered(body) -> void:
	if body is Enemy:
		_add_enemy(body)


func _on_Range_body_exited(body: Node) -> void:
	if body is Enemy:
		_forget_enemy(body)


func update_items(item_slot: String = "", item = null):
	_reset()

	if item_slot != "":
		tower_items_held[item_slot] = item

	itemsHeld[0] = tower_items_held["Slot1"]
	itemsHeld[1] = tower_items_held["Slot2"]
	itemsHeld[2] = tower_items_held["Slot3"]
	itemsHeld[3] = tower_items_held["Slot4"]
	tensorItems[0] = tower_items_held["QuantumSlot1"]
	tensorItems[1] = tower_items_held["QuantumSlot2"]
	tensorItems[2] = tower_items_held["QuantumSlot3"]
	tensorItems[3] = tower_items_held["QuantumSlot4"]
	tensorItems[4] = tower_items_held["QuantumSlot5"]

	for quodite in itemsHeld:
		if quodite == null:
			continue
		_equip_quodite_item(quodite)
	for tensor in tensorItems:
		if tensor == null:
			continue
		is_tensor = true
		_equip_tensor_item(tensor)
	var prob_result = self.qn.simulate_and_get_probabilities_dict()
	probs = prob_result if isRed else {"0": prob_result["1"], "1": prob_result["0"]}

	#Make tensor towers damage 0
	if is_tensor:
		_set_tower_dmg(0)


func _equip_tensor_item(tensor):
	var func_to_call = tensor.tensor_func_name
	match tensor.tensor_func_name:
		'h':
			self.qn.qc.h(0)
		'x':
			self.qn.qc.x(0)
		'y':
			self.qn.qc.y(0)
		'z':
			self.qn.qc.z(0)
		'rx':
			self.qn.qc.rx(PI / 4, 0)
		'rz':
			self.qn.qc.rz(PI / 4, 0)
		'ry':
			self.qn.qc.ry(PI / 4, 0)


func _equip_quodite_item(item):
	# All the current stats of the tower
	if item.damageIncrease != 0:
		weapon.damage = tower_damage + item.damageIncrease
	if item.attackSpeedIncrease != 0:
		var new_tower_attack_speed = tower_attack_speed * 100 / (100 + item.attackSpeedIncrease)
		$Timer.set_wait_time(new_tower_attack_speed)
	if item.rangeIncrease != 0:
		$Range/RangeRadius.set_radius(range_radius + item.rangeIncrease)


func _drop_item(slot: String):
	var temp = tower_items_held[slot]
	tower_items_held[slot] = null
	return temp


func _set_tower_dmg(damage: int) -> void:
	tower_damage = damage
