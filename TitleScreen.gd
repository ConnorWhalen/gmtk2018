extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal buttonPressed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
#	if Input.is_key_pressed(KEY_*):
#		emit_signal("buttonPressed")
	if Input.anyKeyDown():
		emit_signal("buttonPressed")
	pass
