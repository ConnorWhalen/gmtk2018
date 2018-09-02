extends AudioStreamPlayer

export var songname = "clap00.ogg"
var song_time

func _ready():
	self.play(0.0)

func _process(delta):
	song_time = self.get_playback_position()
	if song_time > 38.4:
		self.play(0.0)