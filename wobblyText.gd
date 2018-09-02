extends Node2D

# class member variables go here, for example:
export var completeText = ""
export var textSize = 5
export var textMaxWobble = 5
export var horizontalSpacing = 15

var wobbleTimer = 0
const WOBBLE_RESET_TIME = 0.2

func _ready():
	var charIdx = 0
	for currentChar in completeText:
		var newChild = Label.new()
		newChild.text = currentChar
		newChild.rect_position.x += self.position.x + horizontalSpacing*charIdx
		newChild.rect_position.y = self.position.y
		self.add_child(newChild)
		charIdx += 1
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	wobbleTimer += delta
	var childNumber = 0
	for childText in self.get_children():
		var newOffsetX = (randi() % 3) -0.25
		var newOffsetY = (randi() % 3) -0.25
		childText.rect_position = childText.rect_position + Vector2(newOffsetX, newOffsetY)
		if wobbleTimer >= WOBBLE_RESET_TIME:
			childText.rect_position.x = self.position.x + horizontalSpacing*childNumber
			childText.rect_position.y = self.position.y
		childNumber += 1
	if wobbleTimer >= WOBBLE_RESET_TIME: wobbleTimer = 0
	pass

func recreateTextLabels():
	# Can optimize later but this is easiest for now
	for child in self.get_children():
		self.remove_child(child)
	var charIdx = 0
	for currentChar in completeText:
		var newChild = Label.new()
		newChild.text = currentChar
		newChild.rect_position.x += self.position.x + horizontalSpacing*charIdx
		newChild.rect_position.y = self.position.y
		self.add_child(newChild)
		charIdx += 1	
	pass