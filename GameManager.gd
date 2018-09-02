extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(PackedScene) var initialScene

onready var currentScene = initialScene.instance()
onready var gameScene = preload("res://stage.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# load menu
	currentScene = initialScene.instance()
	self.add_child(currentScene)
	currentScene.connect("buttonPressed", self, "on_pass_title")
	pass

func on_pass_title():
	self.remove_child(currentScene)
	currentScene = gameScene.instance()
	self.add_child(currentScene)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
