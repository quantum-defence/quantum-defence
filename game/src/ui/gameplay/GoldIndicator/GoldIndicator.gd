extends Label

onready var _timer: Timer = $Timer

func _make_visible():
	self.visible = true

func _make_invisible():
	self.visible = false	

func _toggle_visible():
	if (self.visible == true):
		_make_invisible()
	else:
		_make_visible()	

func _on_Timer_timeout():
	_toggle_visible()
