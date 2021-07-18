extends AudioStreamPlayer

class_name CustomAudioPlayer


func take_file(audio_file: String, is_loop: bool):
	assert(File.new().file_exists(audio_file), "audio file does not exist")

	# load is memoized internally by godot, there is no need to optimise this
	var audio = load(audio_file)
	if ".ogg" in audio_file:
		audio.set_loop(is_loop)
	else:
		assert(false, 'Audio should be .ogg')
	self.stream = audio
