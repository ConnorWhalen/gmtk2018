extends Node2D

const SCROLL_SPEED = 300
const PLAYER_BUFFER_LEFT = 300
const PLAYER_BUFFER_RIGHT = 300
const PLAYER_BUFFER_UP = 200
const PLAYER_BUFFER_RIGHT = 200

var screen_size
var checklist
var cupboard_manager

func _ready():
	screen_size = get_viewport_rect().size

	var background = get_node("scrolling/background")
	var background_rect = background.get_texture().get_size()*background.scale

	var camera = get_node("camera")
	camera.position = background.position
	camera.init(screen_size*0.5)
	camera.limit_left = background.position.x - background_rect.x*0.5
	camera.limit_right = background.position.x + background_rect.x*0.5
	camera.limit_top = background.position.y - background_rect.y*0.5
	camera.limit_bottom = background.position.y + background_rect.y*0.5
	camera.current = true

	var player = get_node("static/player")
	player.init(player.position)

	checklist = get_node("static/checklist")
	checklist.init([90, 270, 180, 0])

	cupboard_manager = get_node("scrolling/cupboard_manager")
	cupboard_manager.init(
		[Vector2(-100, 100), Vector2(400, 100), Vector2(900, 100), Vector2(1400, 100), Vector2(-100, 300), Vector2(400, 300), Vector2(900, 300), Vector2(1400, 300)],
		get_node("static/player/left_detector"),
		get_node("static/player/right_detector"),
		camera,
		player)

func _process(delta):
	var camera = get_node("camera")
	
	var player = get_node("static/player")
	# print(player.position)
	if Input.is_action_pressed("scroll_left"):
		if player.position.x > -PLAYER_BUFFER_LEFT:
			player.position.x -= SCROLL_SPEED * delta
		elif (camera.position.x - screen_size.x*0.5) > camera.limit_left:
			camera.position.x -= SCROLL_SPEED * delta

	if Input.is_action_pressed("scroll_right"):
		if player.position.x < PLAYER_BUFFER_LEFT:
			player.position.x += SCROLL_SPEED * delta
		elif (camera.position.x + screen_size.x*0.5) < camera.limit_right:
			camera.position.x += SCROLL_SPEED * delta

	if Input.is_action_pressed("scroll_up"):
		if player.position.y > -PLAYER_BUFFER_UP:
			player.position.y -= SCROLL_SPEED * delta
		elif (camera.position.y - screen_size.y*0.5) > camera.limit_top:
			camera.position.y -= SCROLL_SPEED * delta

	if Input.is_action_pressed("scroll_down"):
		if player.position.y < PLAYER_BUFFER_UP:
			player.position.y += SCROLL_SPEED * delta
		elif (camera.position.y + screen_size.y*0.5) < camera.limit_bottom:
			camera.position.y += SCROLL_SPEED * delta

	# if (Input.is_action_just_pressed("space")):
	# 	checklist.check()
	# 	if checklist.complete():
	# 		get_node("scrolling").visible = false

	if (Input.is_action_just_pressed("left_select")):
		var success = cupboard_manager.select_left()
		if (success):
			checklist.check()
			if checklist.complete():
				get_node("scrolling").visible = false


	if (Input.is_action_just_pressed("right_select")):
		var success = cupboard_manager.select_right()
		if (success):
			checklist.check()
			if checklist.complete():
				get_node("scrolling").visible = false
