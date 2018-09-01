extends Node2D

var type
var ingredient

func _ready():	
	pass

func _process(delta):
	pass

func size():
	print(ingredient.get_texture())
	return ingredient.get_texture().get_size()

func reveal():
	ingredient.modulate = "#000000"
	ingredient.visible = true

func complete():
	ingredient.modulate = "#ffffff"

func init(type_):
	type = type_
	ingredient = get_node(type_)

func get_type():
	return type
