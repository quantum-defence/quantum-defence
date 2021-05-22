extends Enemy

func _ready() -> void:
	# testing inheritance model here
	_health = 10.0 # die on one shot
	death_rattle_time = 4.0 # take longer to disappear
