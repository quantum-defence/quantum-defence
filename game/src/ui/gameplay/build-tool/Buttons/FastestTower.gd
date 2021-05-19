extends Control

var fastestTower = preload("res://src/environment/towers/FastestTower.tscn")

func _on_Button_pressed():
	print("Fastest Tower chosed for build target")
	self.get_parent().set_towerBuilder(fastestTower)
