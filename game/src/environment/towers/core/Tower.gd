extends KinematicBody2D
class_name Tower

# var firing_interval := 0.2
#External properties
#Enemy Related
onready var isPlacing : bool = true
onready var _target : Enemy = null
onready var _enemiesInRange := []
onready var _timer : Timer = $Timer

func _ready() -> void:
	#_timer.set_wait_time(firing_interval)
	_timer.connect("timeout", self, "_fire")

func _fire() -> void:
	var weapon = preload("res://src/projectile/core/Projectile.tscn").instance()
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
	
	if (isPlacing): 
		var t := Transform2D.IDENTITY
		t.origin = get_global_mouse_position()
		var colliding = test_move(t, Vector2.ZERO)
		position = t.origin
		modulate = Color.red if colliding else Color.yellow
		modulate.a = 0.75 
		if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
			isPlacing = false 
	else:
		modulate = Color.white
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
