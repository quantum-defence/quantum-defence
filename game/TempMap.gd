extends Node2D

onready var smth = get_node("Smth")
onready var base = get_node("Base")

func _process(delta):
	print(smth)
	print(base)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
