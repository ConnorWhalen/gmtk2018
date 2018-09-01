extends Camera2D

var initial_position

func _ready():
	pass

func _process(delta):
	pass

func init(position):
	initial_position = position

func location():
	return self.position - initial_position
