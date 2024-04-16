extends Node2D


func get_closest_path(p_position: Vector2):
	var closest_point_distance = null
	var closest_path = null
	for path in get_children():
		var potential_closes_point = path.curve.get_closest_point(p_position)
		var distance_to_potential_closest_point = p_position.distance_to(potential_closes_point)
		if closest_point_distance == null or distance_to_potential_closest_point <= closest_point_distance:
			closest_point_distance = distance_to_potential_closest_point
			closest_path = path
	return closest_path

func add_to_path(path_follow_2d: PathFollow2D):
	var closest_path_to_summoning_portal = get_closest_path(path_follow_2d.position)
	path_follow_2d.set_progress(closest_path_to_summoning_portal.curve.get_closest_offset(path_follow_2d.position))
	closest_path_to_summoning_portal.add_child(path_follow_2d)

func get_closest_position_on_path(p_position: Vector2):
	var closest_path = get_closest_path(p_position)
	return closest_path.curve.get_closest_point(p_position)

func desummon_all_monsters():
	for path in get_children():
		path.desummon_all_monsters()
