extends Node2D

var timer
var button

func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_pressed")
	timer.set_wait_time( 2 )
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()

var counter = 0
func _on_Timer_pressed():

	counter += 1
	print(counter)
