extends Node2D
onready var ingredient = preload("res://ingredient.tscn")

const START_POSITION = Vector2(0, 300)
const SLIDE_IN_POSITION = Vector2(0, 0)

const ZOOM_SCALE_LEFT = Vector2(2, 2)
const ZOOM_SCALE_RIGHT = Vector2(-2, 2)
const ZOOM_LENGTH = 2

signal grab_food(food, which_hand)
signal win_screen

var initial_position
var left_hand
var right_hand

var ingredients = []

var sliding_in = false
var slide_in_increment = 450

var zooming = false
var remaining_zoom
var left_hand_cw = true
var right_hand_cw = false
var angle_increment = 360
var angle_threshold = 1
var zoom_scale_left_delta
var zoom_scale_right_delta
var zoom_translate_delta

var check_done = false

func _ready():
	self.position = START_POSITION
	get_node("../..").connect("grab_food", self, "_grab_food")
	self.connect("win_screen", get_node("../.."), "_win_screen")

func _process(delta):
	if sliding_in:
		self.position.y -= slide_in_increment * delta
		slide_in_increment -= 325 * delta
		if self.position.y < SLIDE_IN_POSITION.y:
			self.position.y = SLIDE_IN_POSITION.y
			sliding_in = false

	if zooming:
		left_hand.get_child(0).scale += zoom_scale_left_delta * delta
		right_hand.get_child(0).scale += zoom_scale_right_delta * delta
		for ingredient in ingredients:
			ingredient.ingred.scale += zoom_scale_left_delta * delta * 0.5

		# if (left_hand_cw):
		# 	left_hand.get_child(0).rotation_degrees += angle_increment * delta
		# 	if left_hand.get_child(0).rotation_degrees > angle_threshold:
		# 		left_hand_cw = false
		# else:
		# 	left_hand.get_child(0).rotation_degrees -= angle_increment * delta
		# 	if left_hand.get_child(0).rotation_degrees < -angle_threshold:
		# 		left_hand_cw = true

		# if (right_hand_cw):
		# 	right_hand.get_child(0).rotation_degrees += angle_increment * delta
		# 	if right_hand.get_child(0).rotation_degrees > angle_threshold:
		# 		right_hand_cw = false
		# else:
		# 	right_hand.get_child(0).rotation_degrees -= angle_increment * delta
		# 	if right_hand.get_child(0).rotation_degrees < -angle_threshold:
		# 		right_hand_cw = true

		self.position += zoom_translate_delta * delta

		remaining_zoom -= delta
		if remaining_zoom < 0:
			zooming = false
			check_done = true
			for ingredient in ingredients:
				ingredient.flag_exit()

	if check_done:
		var done = true
		for ingredient in ingredients:
			if ingredient.is_done() == false:
				done = false
		if Input.is_action_just_pressed("win"):
			done = true
		if done:
			emit_signal("win_screen")
			check_done = false

func init(position):
	initial_position = position
	self.connect("grab_food" ,self, "_grab_food")
	left_hand = get_node("left_hand")
	right_hand = get_node("right_hand")

func location():
	return self.position - initial_position

func _grab_food(food, which_hand):
	var new_food = ingredient.instance()
	self.add_child(new_food)
	ingredients.append(new_food)
	new_food.init(left_hand, right_hand, which_hand, food)

func slide_in():
	sliding_in = true

func zoom():
	zooming = true
	remaining_zoom = ZOOM_LENGTH
	zoom_scale_left_delta = ZOOM_SCALE_LEFT/remaining_zoom
	zoom_scale_right_delta = ZOOM_SCALE_RIGHT/remaining_zoom
	zoom_translate_delta = -self.location()/remaining_zoom
