extends AudioStreamPlayer

var song_time

func _ready():
	pass

func _process(delta):
	song_time = self.get_playback_position()
	if song_time > 38.4:
		self.play(0.0)