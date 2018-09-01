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
	# var nearest_l = self.nearest(left_detector)
	# var left_cupboard_dist = nearest_l[0]
	# var left_cupboard = nearest_l[1]
	# if left_cupboard_dist < 50:
	# 	if left_cupboard != left_highlighted:
	# 		print("SELECTED LEFT")
	# 		if left_highlighted != null:
	# 			self.unhighlight(left_highlighted)
	# 		self.highlight(left_cupboard)
	# 		left_highlighted = left_cupboard
	# else:
	# 	if left_highlighted != null:
	# 		self.unhighlight(left_highlighted)
	# 	left_highlighted = null

	# var nearest_r = self.nearest(right_detector)
	# var right_cupboard_dist = nearest_r[0]
	# var right_cupboard = nearest_r[1]
	# if right_cupboard_dist < 50:
	# 	if right_cupboard != right_highlighted:
	# 		print("SELECTED RIGHT")
	# 		if right_highlighted != null:
	# 			self.unhighlight(right_highlighted)
	# 		self.highlight(right_cupboard)
	# 		right_highlighted = right_cupboard
	# else:
	# 	if right_highlighted != null:
	# 		self.unhighlight(right_highlighted)
	# 	right_highlighted = null

	# print(left_cupboard_dist)
	# #print(left_cupboard)
	# print(right_cupboard_dist)
	# #print(right_cupboard)

	var left_cupboard = self.collide(left_detector+camera.location())
	if left_cupboard != left_highlighted:
		if left_highlighted != null:
			self.unhighlight(left_highlighted)
		if left_cupboard != null:
			self.highlight(left_cupboard)

	var right_cupboard = self.collide(right_detector+camera.location())
	if right_cupboard != right_highlighted:
		if right_highlighted != null:
			self.unhighlight(right_highlighted)
		if right_cupboard != null:
			self.highlight(right_cupboard)


func init(items, left_detector_, right_detector_, camera_):
	for i in range(len(items)):
		var cupboard = cupboard_scene.instance()
		cupboard.position = items[i]
		cupboard.init(items[i])
		self.add_child(cupboard)
	left_detector = left_detector_
	right_detector = right_detector_
	camera = camera_

func nearest(point):
	#print(camera.location())
	#print(point+camera.location())
	var closest_dist = null
	var closest_index = null
	var children = self.get_children()
	for i in range(len(children)):
		var cupboard = children[i]
		var dist = cupboard.position.distance_to(point+camera.location())
		if closest_dist == null or dist < closest_dist:
			closest_dist = dist
			closest_index = i
	return [closest_dist, closest_index]

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
