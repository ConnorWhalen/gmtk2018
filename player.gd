extends Node2D
onready var ingredient = preload("res://ingredient.tscn")

var initial_position
var left_hand
var right_hand

func _ready():
	pass

func _process(delta):
	pass

func init(position):
	initial_position = position
	left_hand = get_node("left_hand")
	right_hand = get_node("right_hand")

func location():
	return self.position - initial_position

func _on_Node2D_grab_food(food, which_hand):
	var new_food = ingredient.instance()
	new_food._init(left_hand, right_hand, which_hand, food)
	
