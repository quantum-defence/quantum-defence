extends Node2D

var start
var end
var speed
var direction

#Should be the actual enemy
var target

func _ready():
	speed = 400

func _init(target,start):
	end = target.position
	start = start
	direction = end - start
	
func _process(delta):
	if (target.get_ref()):
		get_tree().queue_free()
	self.position = position + direction.normalized() * speed
	
func _on_Area2D_area_entered(area):
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
