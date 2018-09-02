extends AudioStreamPlayer

export var songname = "clap00.ogg"
var song_time
var track

func _ready():
	pass

func _process(delta):
	if track:
		song_time = self.track.get_playback_position()
		if song_time > 38.4:
			self.track.play(0.0)

func init(track_):
	self.track = get_node(track_)
	self.track.play(0.0)