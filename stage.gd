extends Node2D

const SCROLL_SPEED = 200

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var scrollingNode = get_node("scrolling")
	
	if (Input.is_action_pressed("scroll_left")):
		scrollingNode.position.x += SCROLL_SPEED * delta

	if (Input.is_action_pressed("scroll_right")):
		scrollingNode.position.x -= SCROLL_SPEED * delta

	if (Input.is_action_pressed("scroll_up")):
		scrollingNode.position.y += SCROLL_SPEED * delta

	if (Input.is_action_pressed("scroll_down")):
		scrollingNode.position.y -= SCROLL_SPEED * delta
