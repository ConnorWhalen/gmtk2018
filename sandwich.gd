extends Node2D

const SLIDE_SPEED = 200

signal sandwich_done

var sliding = false
var remaining_slide

func _ready():
	self.connect("sandwich_done", get_node("../.."), "_sandwich_done")

func _process(delta):
	if sliding:
		self.get_child(0).position.y += SLIDE_SPEED * delta
		remaining_slide -= delta
		if remaining_slide < 0:
			sliding = false
			emit_signal("sandwich_done")


func slide_in():
	remaining_slide = 3.25
	sliding = true
