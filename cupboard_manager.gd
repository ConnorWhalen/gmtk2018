extends Node2D

onready var cupboard_scene = preload("res://cupboard.tscn")

var left_detector
var right_detector
var camera
var left_highlighted = null
var right_highlighted = null

func _ready():
	pass

func _process(delta):
	var left_cupboard = self.collide(left_detector+camera.location())
	if left_cupboard != left_highlighted:
		if left_highlighted != null:
			self.unhighlight(left_highlighted)
		if left_cupboard != null:
			self.highlight(left_cupboard)
		left_highlighted = left_cupboard

	var right_cupboard = self.collide(right_detector+camera.location())
	if right_cupboard != right_highlighted:
		if right_highlighted != null:
			self.unhighlight(right_highlighted)
		if right_cupboard != null:
			self.highlight(right_cupboard)
		right_highlighted = right_cupboard


func init(items, left_detector_, right_detector_, camera_):
	for i in range(len(items)):
		var cupboard = cupboard_scene.instance()
		cupboard.position = items[i]
		cupboard.init(items[i])
		self.add_child(cupboard)
	left_detector = left_detector_
	right_detector = right_detector_
	camera = camera_

func collide(point):
	var children = self.get_children()
	for i in range(len(children)):
		if children[i].collide(point):
			return i
	return null

func highlight(index):
	self.get_children()[index].highlight()

func unhighlight(index):
	self.get_children()[index].unhighlight()

func select_left():
	if left_highlighted != null:
		return self.get_children()[left_highlighted].select()
	return false

func select_right():
	if right_highlighted != null:
		return self.get_children()[right_highlighted].select()
	return false
