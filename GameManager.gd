extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(PackedScene) var initialScene

onready var currentScene = initialScene.instance()
onready var controlsScene = preload("res://ControlsExplanation.tscn").instance()
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
	currentScene = controlsScene
	self.add_child(currentScene)
	currentScene.connect("controlsAcknowledged", self, "on_pass_controls")
	
func on_pass_controls():
	self.remove_child(currentScene)
	currentScene = gameScene.instance()
	self.add_child(currentScene)
	currentScene.connect("stage_lose", self, "on_stage_lose")
	currentScene.connect("stage_win", self, "on_stage_win")

func on_stage_lose():
	self.remove_child(currentScene)
	currentScene = gameScene.instance()
	self.add_child(currentScene)
	
func on_stage_win():
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
