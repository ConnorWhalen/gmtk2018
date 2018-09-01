extends Node2D

var type

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

func init(type_):
	type = type_

func get_type():
	return type
