extends Node2D

class_name Item

#export all the stats so that can apply to the tower later on
export var damageIncrease: int
export var attackSpeedIncrease: int
export var rangeIncrease: int
export var projectileSpeed: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _equip_on_tower():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
