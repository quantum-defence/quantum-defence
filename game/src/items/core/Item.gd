extends Node2D

class_name Item

#export all the stats so that can apply to the tower later on
export var damageIncrease: int = 0
export var attackSpeedIncrease: int = 0
export var rangeIncrease: int = 0
export var isTensor: bool = false
export var tensor_func_name: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _equip_on_tower():
	pass
