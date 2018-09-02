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
	elapse = 0.0

func _process(delta):
	elapse += delta
	interp_value = 2.0/2.4 * elapse
	if elapse > 2.8:
		pass
	whole = floor(interp_value)
	fractional = fmod(interp_value, 1.0)
	self.position = path.interpolate(whole, fractional)
	var left_check = left_hand_rect.has_point(self.position)
	var left_juggle = Input.is_action_just_pressed("left_select")
	if left_check and left_juggle and elapse>2.0:
		self._left()
	var right_check = right_hand_rect.has_point(self.position)
	var right_juggle = Input.is_action_just_pressed("right_select")
	if right_check and right_juggle and elapse>2.0:
		self._right()

func _left():
	path = self._generate_path(right_hand.position)
	elapse = 0.0

func _right():
	path = self._generate_path(left_hand.position)
	elapse = 0.0

func init(left_h, right_h, which_h, type):
	ingred = get_node(type)
	ingred_size = ingred.get_texture().get_size()*ingred.scale
	left_hand = left_h
	right_hand = right_h
	left_hand_size = left_hand.get_node("leftHandAnimatedSprite/AnimatedSprite").frames.get_frame("Idle", 0).get_size()
	right_hand_size = right_hand.get_node("leftHandAnimatedSprite/AnimatedSprite").frames.get_frame("Idle", 0).get_size()
	left_hand_rect = Rect2(left_hand.position - left_hand_size/2, left_hand_size)
	right_hand_rect = Rect2(right_hand.position - right_hand_size/2, right_hand_size)
	ingred.visible = true
	which_hand = which_h
	if which_hand == "left":
		self.position = left_hand.position
		path = self._generate_path(right_hand.position)
	if which_hand == "right":
		self.position = right_hand.position
		path = self._generate_path(left_hand.position)

	

func _generate_path(new_location):
	var new_path = Curve2D.new()
	var height = 300.0 + 300.0*(randf() - 0.5)
	var height_control = height * 0.2
	var control_distance = 200.0 + 100.0*(randf() - 0.5)
	var half_point = Vector2((self.position.x + new_location.x)/2.0, new_location.y -height)
	if new_location.x > self.position.x:
		new_path.add_point(self.position, Vector2(0.0, height_control), Vector2(0.0, -height_control))
		new_path.add_point(half_point, Vector2(-control_distance, 0.0), Vector2(control_distance, 0.0))
		new_path.add_point(new_location, Vector2(0.0, -height_control), Vector2(0.0, height_control))
		new_path.add_point(Vector2(new_location.x + 100, 1000.0))
	else:
		new_path.add_point(self.position, Vector2(0.0, height_control), Vector2(0.0, -height_control))
		new_path.add_point(half_point, Vector2(control_distance, 0.0), Vector2(-control_distance, 0.0))
		new_path.add_point(new_location, Vector2(0.0, -height_control), Vector2(0.0, height_control))
		new_path.add_point(Vector2(new_location.x - 100, 1000.0))
	return new_path
