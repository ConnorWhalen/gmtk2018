extends AudioStreamPlayer
var play_miss = false

func _ready():
	get_node("../..").connect("miss_sample", self, "_clap_sample")

func _process(delta):
	if play_miss:
		play_miss = false
		self.play(0.0)

func _clap_sample():
	play_miss = true
