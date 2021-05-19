extends Control

var shotGunTower = preload("res://src/environment/towers/ShotGunTower.tscn")

func _on_Button_pressed():
	print("shotGun Tower chosed for build target")
	self.get_parent().set_towerBuilder(shotGunTower)
