extends Node

var levels = {
	"BgMusic": 100.0,
	"FX": 100.0,
	"GameFx": 100.0,
	"UIFx": 100.0,
}


func _ready() -> void:
	if OS.is_debug_build():
		set_bg_vol(10)
		set_fx_vol(70)
	else:
		set_bg_vol(70)
		set_fx_vol(70)


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
	levels[bus_name] = value
	assert(value >= 0.0 && value <= 100.0, 'volume level not between 0 and 100')
	AudioServer.set_bus_volume_db(_get_audio_bus(bus_name), linear2db(value / 100.0))


func set_fx_vol(value: float):
	_set_vol("FX", value)


func set_bg_vol(value: float):
	_set_vol("BgMusic", value)
