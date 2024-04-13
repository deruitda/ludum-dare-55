extends Path2D

const BASIC_HUMAN_SCENE = preload("res://assets/scenes/Humans/basic_human.tscn");



func add_human():
	var new_human = load("res://assets/scenes/Humans/basic_human.tscn").instantiate()
	add_child(new_human)
	# Set human's position to the first point of the path
	#if curve.get_point_count() > 0:
		#new_human.position = curve.get_point_position(0)


func _on_timer_timeout():
	print('hi')
	add_human()
