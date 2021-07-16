extends CustomAudioPlayer

const prefix = "res://assets/audio/"

const paths = []

enum MUSIC {
	test,
}

export (MUSIC) var choice = MUSIC.test


func _ready() -> void:
	take_file(prefix + paths[choice], false)
	play()
