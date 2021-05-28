extends KinematicBody2D

export var move_speed = 2000
var isPlacing = true

func _process(delta):
	if (isPlacing):
		var t := Transform2D.IDENTITY
		t.origin = get_global_mouse_position()
		var colliding = test_move(t, Vector2.ZERO)
		position = t.origin
		modulate = Color.red if colliding else Color.yellow
		modulate.a = 0.75 
		if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
			isPlacing = false
	else: 
		modulate = Color.white


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

