extends Node2D

signal collect_food

var has_item
var closed
var rect
var type
var ingredient

func _ready():
	pass

func _process(delta):
	pass

func init(position, type_):
	var rect_size = get_node("closed").get_texture().get_size()*get_node("closed").scale
	rect = Rect2(position - rect_size*0.5, rect_size)
	type = type_
	ingredient = get_node("ingredient/" + type)
	self.close()
	has_item = true
	closed = true

func open():
	get_node("closed").visible = false
	get_node("open").visible = true
	if has_item:
		ingredient.visible = true
	closed = false

func close():
	get_node("open").visible = false
	ingredient.visible = false
	get_node("closed").visible = true
	closed = true

func collect():
	has_item = false
	ingredient.visible = false

func highlight():
	get_node("closed").scale = Vector2(0.6, 0.6)
	ingredient.scale = Vector2(0.55, 0.55)

func unhighlight():
	get_node("closed").scale = Vector2(0.55, 0.55)
	ingredient.scale = Vector2(0.5, 0.5)

func collide(point):
	return rect.has_point(point)

func is_closed():
	return closed

func select(type_):
	if closed:
		self.open()
	elif has_item and type == type_:
		self.collect()
		return type
	return false
