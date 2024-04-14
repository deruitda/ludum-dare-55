extends Node2D

@export var patron_class: String = ""
@export var souls = 1
@export var health = 1
@export var speed = 100.0

@export var _visual_resource: Resource

func get_path_follow_area_2d() -> Area2D:
	var path_follow_area_2d = get_node("PathFollowArea2D")
	assert(path_follow_area_2d != null, str("PathFollowArea2D must be set in ", patron_class, " scene"))
	return path_follow_area_2d


func _on_path_follow_area_2d_area_entered(area):
	print("touched")
