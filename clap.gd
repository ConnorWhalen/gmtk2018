extends AudioStreamPlayer
var play_clap = false

func _ready():
	get_node("..").connect("clap_sample", self, "_clap_sample")

func _process(delta):
	if play_clap:
		play_clap = false
		self.play(0.0)

func _clap_sample():
	play_clap = true