extends Node2D

signal clap_sample
signal grab_food(a, b)

const SCROLL_SPEED = 300
const PLAYER_BUFFER_LEFT = 200
const PLAYER_BUFFER_RIGHT = 300
const PLAYER_BUFFER_UP = 400
const PLAYER_BUFFER_BOTTOM = 0

var screen_size
var checklist
var cupboard_manager

var playing = false

func _ready():
	var stage_file = File.new()
	stage_file.open("res://1.stage", File.READ)

	var checklist_items_count = int(stage_file.get_line())
	var checklist_items = []
	for i in range(checklist_items_count):
		checklist_items.append(stage_file.get_line())

	var cupboard_count = int(stage_file.get_line())
	var cupboard_positions = []
	for i in range(cupboard_count):
		var x = stage_file.get_line()
		var y = stage_file.get_line()
		cupboard_positions.append(Vector2(x, y))

	var cupboard_items = []
	for i in range(cupboard_count):
		cupboard_items.append(stage_file.get_line())

	var scan_point_count = int(stage_file.get_line())
	var scan_positions = []
	for i in range(scan_point_count):
		var x = stage_file.get_line()
		var y = stage_file.get_line()
		scan_positions.append(Vector2(x, y))

	var scan_lengths = []
	for i in range(scan_point_count-1):
		scan_lengths.append(float(stage_file.get_line()))

	screen_size = get_viewport_rect().size

	var background = get_node("scrolling/background")
	var background_rect = background.get_texture().get_size()*background.scale

	var camera = get_node("camera")
	camera.position = background.position
	camera.init(screen_size*0.5, scan_positions, scan_lengths)
	camera.limit_left = background.position.x - background_rect.x*0.5
	camera.limit_right = background.position.x + background_rect.x*0.5
	camera.limit_top = background.position.y - background_rect.y*0.5
	camera.limit_bottom = background.position.y + background_rect.y*0.5
	camera.current = true

	var player = get_node("static/player")
	player.init(Vector2(0, 0))

	checklist = get_node("static/checklist")
	checklist.init(checklist_items)

	cupboard_manager = get_node("scrolling/cupboard_manager")
	cupboard_manager.init(
		cupboard_positions,
		cupboard_items,
		get_node("static/player/left_detector"),
		get_node("static/player/right_detector"),
		camera,
		player)

func _process(delta):
	var camera = get_node("camera")
	var player = get_node("static/player")
	
	if playing:
		if Input.is_action_pressed("scroll_left"):
			if player.position.x > -PLAYER_BUFFER_LEFT:
				player.position.x -= SCROLL_SPEED * delta
			elif (camera.position.x - screen_size.x*0.5) > camera.limit_left:
				camera.position.x -= SCROLL_SPEED * delta

		if Input.is_action_pressed("scroll_right"):
			if player.position.x < PLAYER_BUFFER_RIGHT:
				player.position.x += SCROLL_SPEED * delta
			elif (camera.position.x + screen_size.x*0.5) < camera.limit_right:
				camera.position.x += SCROLL_SPEED * delta

		if Input.is_action_pressed("scroll_up"):
			if player.position.y > -PLAYER_BUFFER_UP:
				player.position.y -= SCROLL_SPEED * delta
			elif (camera.position.y - screen_size.y*0.5) > camera.limit_top:
				camera.position.y -= SCROLL_SPEED * delta

		if Input.is_action_pressed("scroll_down"):
			if player.position.y < PLAYER_BUFFER_BOTTOM:
				player.position.y += SCROLL_SPEED * delta
			elif (camera.position.y + screen_size.y*0.5) < camera.limit_bottom:
				camera.position.y += SCROLL_SPEED * delta

		if (Input.is_action_just_pressed("left_select")):
			var food = cupboard_manager.select_left(checklist.current_item())
			if (food):
				collect_food(food, player, "left")

		if (Input.is_action_just_pressed("right_select")):
			var food = cupboard_manager.select_right(checklist.current_item())
			if (food):
				collect_food(food, player, "right")
	else:
		if camera.done_scan():
			cupboard_manager.close_all()
			playing = true
			player.slide_in()


func collect_food(food, player, which_h):
	emit_signal("clap_sample")
	emit_signal("grab_food", food, which_h)
	checklist.check()
	if checklist.complete():
		player.zoom()