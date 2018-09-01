extends Node2D

func _ready():	
	pass

func _process(delta):
	pass

func size():
	return get_node("incomplete").get_texture().get_size()

func reveal():
	get_node("incomplete").visible = true

func complete():
	get_node("incomplete").visible = false
	get_node("complete").visible = true
