extends Control

var ultimateTower = preload("res://src/environment/towers/UltimateTower.tscn")

func _on_Button_pressed():
	print("Ultimate Tower chosed for build target")
	self.get_parent().set_towerBuilder(ultimateTower)