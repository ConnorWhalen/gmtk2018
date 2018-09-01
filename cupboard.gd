extends Node2D

var has_item
var closed
var rect

func _ready():
	pass

func _process(delta):
	pass

func init(position):
	var rect_size = get_node("closed").get_texture().get_size()
	rect = Rect2(position - rect_size*0.5, rect_size)
	self.close()
	has_item = true
	closed = true

func open():
	get_node("closed").visible = false
	get_node("open").visible = true
	if has_item:
		get_node("item").visible = true
	closed = false

func close():
	get_node("open").visible = false
	get_node("item").visible = false
	get_node("closed").visible = true
	closed = true

func collect():
	has_item = false
	get_node("item").visible = false

func highlight():
	get_node("closed").scale = Vector2(1.2, 1.2)
	get_node("item").scale = Vector2(0.55, 0.55)

func unhighlight():
	get_node("closed").scale = Vector2(1.1, 1.1)
	get_node("item").scale = Vector2(0.5, 0.5)

func collide(point):
	return rect.has_point(point)

func is_closed():
	return closed

func select():
	if closed:
		self.open()
	elif has_item:
		self.collect()
		return true
	return false
