extends Node

func get_random_stream():
	return get_children().pick_random().stream
