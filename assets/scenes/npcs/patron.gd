extends Node2D

@export var patron_class: String = ""
@export var souls = 1
@export var health = 1
@export var speed = 100.0

@export var _visual_resource: Resource
@onready var path_follow_area_2d = $PathFollowArea2D

func get_path_follow_area_2d() -> Area2D:
	assert(path_follow_area_2d != null, str("PathFollowArea2D must be set in ", patron_class, " scene"))
	return path_follow_area_2d
