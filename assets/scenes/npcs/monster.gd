extends Node2D

@export var monster_name: String = ""
@export var _speed: float = 0.0
@export var _max_souls_to_consume: int = 1
@export var _visual_resource: Resource
@export var puzzles: Array[Node2D] = []

@onready var path_follow_area_2d = $PathFollowArea2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#loop = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_random_puzzle() -> Node2D:
	return puzzles.pick_random()

func get_path_follow_area_2d() -> Area2D:
	assert(path_follow_area_2d != null, str("PathFollowArea2D must be set in ", monster_name, " scene"))
	return path_follow_area_2d
