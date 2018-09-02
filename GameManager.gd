extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(PackedScene) var initialScene

var currentScene

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# load menu
	currentScene = initialScene.instance()
	self.add_child(currentScene)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
