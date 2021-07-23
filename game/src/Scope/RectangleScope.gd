extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stop_factor: float = 0.1
var shrink_speed: float = 0.999
var curr_stop_factor = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_stop_scale(stop):
	stop_factor = stop

func _process(delta):
	curr_stop_factor *= shrink_speed
	
	if (curr_stop_factor > stop_factor):
		self.scale = self.scale * shrink_speed
