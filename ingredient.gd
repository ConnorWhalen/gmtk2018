extends Node2D


var right_hand
var left_hand
var left_hand_size
var left_hand_rect
var right_hand_rect
var right_hand_size
var which_hand
var path
var elapse
var interp_value
var whole
var fractional
var ingred
var ingred_size

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	elapse += delta
	interp_value = 2.0/2.56 * elapse
	whole = floor(interp_value)
	fractional = interp_value % 1
	self.posotion = path.interpolate(whole, fractional)
	var left_check = left_hand_rect.has_point(self.position)
	if left_check:
		self._left()
	var right_check = right_hand_rect.has_point(self.position)
	if right_check:
		self._right()

func _left():
	path = self._generate_path(right_hand.position)
	elapse = 0.0

func _right():
	path = self._generate_path(left_hand.poisition)
	elapse = 0.0

func init(left_h, right_h, which_h, type):
	ingred = get_node("ingredient/" + type)
	ingred_size = ingred.get_texture().get_size()*ingred.scale
	left_hand = left_h
	right_hand = right_h
	left_hand_size = left_hand.get_texture().get_size()*left_hand.scale
	right_hand_size = right_hand.get_texture().get_size()*right_hand.scale
	left_hand_rect = Rect2(left_hand.position - left_hand_size, left_hand_size)
	right_hand_rect = Rect2(right_hand.position - right_hand_size, right_hand_size)
	ingred.visible = true
	which_hand = which_h
	if which_hand == "left":
		path = self._generate_path(right_hand.position)
	if which_hand == "right":
		path = self._generate_path(left_hand.position)
	

func _generate_path(new_location):
	var new_path = Curve2D.instance()
	new_path.add_point(self.position)
	var half_point = Vector2((self.position)/2.0, 300.0)
	new_path.add_point(half_point)
	new_path.add_point(new_location)
	return new_path
