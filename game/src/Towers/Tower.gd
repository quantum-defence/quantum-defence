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
	print("fire is being called")
	#Not sure how to make this part of the design ngl
	var weapon = preload("res://src/enemy/EnemyWeapon.tscn").instance()
	get_parent().add_child(weapon)
	weapon.fire(global_position, target.position)


func _process(delta):
	# If their are enemies in range
	
	if enemiesInRange.size() != 0:
	# If no target is assigned put it as the first enemy in the list
		if target == null:
			target = enemiesInRange[0]
		
	else:
			target = null
	
	if (target != null and timer.is_stopped()):
		timer.start()



func _on_Range_body_entered(body):
	print(body)
	if body is KinematicBody2D:
		enemiesInRange.append(body)
