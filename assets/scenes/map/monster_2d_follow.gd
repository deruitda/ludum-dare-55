extends PathFollow2D

@export var monster: Node2D = null

@export var speed = 20.0
# Called when the node enters the scene tree for the first time.
func _ready():
	var path_follow_area_2d = monster.get_path_follow_area_2d()
	monster.remove_child(path_follow_area_2d)
	add_child(path_follow_area_2d)
	loop = false
