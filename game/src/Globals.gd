extends Node

export var bg_music_vol := 70.0
export var fx_vol := 100.0


func _get_audio_bus(bus_name: String):
	# check src/Audio/audio_bus_layout.tres for index
	match bus_name:
		"BgMusic":
			return 1
		"FX":
			return 2
		"GameFx":
			return 3
		"UIFx":
			return 4
		_:
			assert('false', 'audio bus name not known')


func _set_vol(bus_name: String, value: float):
	assert(value >= 0.0 && value <= 100.0, 'volume level not between 0 and 100')
	AudioServer.set_bus_volume_db(_get_audio_bus(bus_name), linear2db(value / 100.0))


func set_fx_vol(value: float):
	_set_vol("FX", value)


func set_bg_vol(value: float):
	_set_vol("BgMusic", value)
