extends Node2D


func get_closest_path(mouse_position):
	var closest_point = null
	var closest_point_distance = null
	var closest_path = null
	var summoning_mouse_position_threshold = null
	for path in get_children():
		var potential_closes_point = path.curve.get_closest_point(mouse_position)
		var distance_to_potential_closest_point = mouse_position.distance_to(potential_closes_point)
		if closest_point_distance == null or distance_to_potential_closest_point <= closest_point_distance:
			closest_point = potential_closes_point
			closest_point_distance = distance_to_potential_closest_point
			closest_path = path
	return closest_path
