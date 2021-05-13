extends Node2D

#Tower properties
var health = 100
var projectile = preload("res://Projectile.tscn")

#External properties
#Enemy Related
onready var target
onready var enemiesInRange = []

#Timer
var timer 
func _ready():
	timer = get_node("Timer")
	timer.set_wait_time(1)
	timer.connect("timeout", self, "_fire")


func _fire():
	#Not sure how to make this part of the design ngl
	var weapon = preload("res://src/enemy/EnemyWeapon.tscn").instance()
	get_parent().add_child(weapon)
	weapon.fire(global_position, target.position)


func _process(delta):
	# If their are enemies in range
	if enemiesInRange.size() != 0:
		print("process called if")
	# If no target is assigned put it as the first enemy in the list
		if target == null:
			target = enemiesInRange[0]
		print("timer called")
		print(target)
		timer.start()
		

	else:
			print("process called else")
			target = null
			

func _on_Range_area_entered(area):
	# Tests if they are an enemy
	print("on Range area entered called")
	if area.get_parent() is Enemy:
		# If no target has been selected asign this one
		if not target:
			target = area

		# Add the enemy to the list
		enemiesInRange.append(area)

func _on_Range_area_exited(area):
	enemiesInRange.erase(area)
