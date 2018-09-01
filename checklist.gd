extends Node2D

const PADDING = 10

onready var checklist_item_scene = preload("res://checklist_item.tscn")

var screen_size
var current = 0
var total
var is_complete = false

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	pass

func init(items_):
	total = len(items_)
	for i in total:
		var child = checklist_item_scene.instance()
		child.init(items_[i])
		var child_size = child.size()
		child.position.x = (child_size.x*0.5 + PADDING) * (2*i + 1) + PADDING
		child.position.y = child_size.y*0.5 + PADDING*2
		self.add_child(child)
	self.get_children()[0].reveal()

func check():
	var item = self.get_children()[current]
	item.complete()
	if current < total-1:
		current += 1
		self.get_children()[current].reveal()
	else:
		is_complete = true
	return true
	return false

func complete():
	return is_complete

func current_item():
	return self.get_children()[current].get_type()
