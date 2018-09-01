extends Node2D

const SCROLL_SPEED = 200

var screen_size
var checklist

func _ready():
	screen_size = get_viewport_rect().size

	checklist = get_node("static/checklist")
	checklist.init([90, 270, 180, 0])

	var background = get_node("scrolling/background")
	var background_rect = background.get_texture().get_size()*background.scale

	var camera = get_node("camera")
	camera.position = background.position
	camera.limit_left = background.position.x - background_rect.x*0.5
	camera.limit_right = background.position.x + background_rect.x*0.5
	camera.limit_top = background.position.y - background_rect.y*0.5
	camera.limit_bottom = background.position.y + background_rect.y*0.5
	camera.current = true
	pass

func _process(delta):
	var camera = get_node("camera")
	
	if (Input.is_action_pressed("scroll_left") and (camera.position.x - screen_size.x*0.5) > camera.limit_left):
		camera.position.x -= SCROLL_SPEED * delta

	if (Input.is_action_pressed("scroll_right") and (camera.position.x + screen_size.x*0.5) < camera.limit_right):
		camera.position.x += SCROLL_SPEED * delta

	if (Input.is_action_pressed("scroll_up") and (camera.position.y - screen_size.y*0.5) > camera.limit_top):
		camera.position.y -= SCROLL_SPEED * delta

	if (Input.is_action_pressed("scroll_down") and (camera.position.y + screen_size.y*0.5) < camera.limit_bottom):
		camera.position.y += SCROLL_SPEED * delta

	if (Input.is_action_just_pressed("space")):
		checklist.check()
		if checklist.complete():
			get_node("scrolling").visible = false
