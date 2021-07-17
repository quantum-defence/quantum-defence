extends Area2D

#Damage per second
export var dps = 10
onready var enemies_in_trap = []


func _on_Area2D_area_entered(area: Area2D):
	if area.get_name() == "Vitals":
		var enemy = area.get_parent()
		enemies_in_trap.append(enemy)


func _on_Timer_timeout():
	if enemies_in_trap.size() != 0:
		for enemy in enemies_in_trap:
			enemy.take_damage(dps, false)


func _on_Area2D_area_exited(area: Area2D):
	if area.get_name() == "Vitals":
		var enemy = area.get_parent()
		enemies_in_trap.erase(enemy)
