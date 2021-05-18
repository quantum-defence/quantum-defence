extends Control

var basicTower = preload("res://src/Towers/BasicTower.tscn")

func _on_Button_pressed():
    print("Basic Tower being selected by builder")
    self.get_parent().set_towerBuilder(basicTower)
