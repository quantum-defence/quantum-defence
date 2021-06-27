extends Enemy

func _ready() -> void:
	# testing inheritance model here
	_health = 100.0 # die on one shot
	death_rattle_time = 2.0 # take longer to disappear
	damage_taken_time = 0.5
	_speed = 100.0
