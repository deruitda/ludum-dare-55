extends Path2D

@export var child_paths: Array[Path2D] = []
@export var is_ending_path: bool = false

func reached_the_end(patron_2d_follow):
	if is_ending_path:
		patron_2d_follow.patron_survived()
	else:
		var next_path = child_paths.pick_random()
		remove_child(patron_2d_follow)
		patron_2d_follow.set_progress(0.0)
		next_path.add_child(patron_2d_follow)
func desummon_all_monsters():
	for child in get_children():
		child.queue_free()
