extends Camera2D

var scan_positions
var scan_lengths
var reference_position
var scan_time
var scanning = false
var done_scan = false
var scan_points
var scan_point
var scan_increment

func _ready():
	pass

func _process(delta):
	if scanning:
		self.position += scan_increment
		scan_time -= 1
		if scan_time == 0:
			scan_point += 1
			if scan_point == scan_points-1:
				scanning = false
				done_scan = true
			else:
				scan_time = scan_lengths[scan_point]
				scan_increment = (scan_positions[scan_point+1]-scan_positions[scan_point])/scan_time

func init(reference_position_, scan_positions_, scan_lengths_):
	reference_position = reference_position_
	self.position = scan_positions_[0]
	scan_positions = scan_positions_
	scan_lengths = scan_lengths_
	scan_time = scan_lengths[0]
	scan_increment = (scan_positions[1]-scan_positions[0])/scan_time
	scan_points = len(scan_positions)
	scan_point = 0
	scanning = true

func location():
	return self.position - reference_position

func done_scan():
	return done_scan
