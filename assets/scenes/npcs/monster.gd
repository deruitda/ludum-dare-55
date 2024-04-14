extends Node2D

@export var monster_name: String = ""
@export var _speed: float = 0.0

@export var _max_souls_to_consume: int = 1
@export var _visual_resource: Resource
@onready var puzzles: Array = []
@export var damage: int = 1

@onready var path_follow_area_2d = $PathFollowArea2D
@onready var _number_of_souls_captured: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#loop = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_random_puzzle():
	return puzzles.pick_random()

func get_capacity_to_consume_souls() -> int:
	print("Soul capacity: ", str(_max_souls_to_consume - _number_of_souls_captured))
	return _max_souls_to_consume - _number_of_souls_captured

func attack(patron: Node2D):
	var num_of_souls_captured = 0
	if get_capacity_to_consume_souls() >= patron.health:
		print("Damage: " + str(damage))
		num_of_souls_captured = patron.capture_souls(damage)
		print("At capacity, captured souls: " + str(num_of_souls_captured))
	else:
		num_of_souls_captured = patron.capture_souls(get_capacity_to_consume_souls())
		print("Not at capacity, captured souls: " + str(num_of_souls_captured))
	_number_of_souls_captured += num_of_souls_captured
	SoulsCapturedSignal.emit_signal("souls_captured", num_of_souls_captured)
	if _number_of_souls_captured == _max_souls_to_consume:
		desummon()

func desummon():
	queue_free()

func _on_path_follow_area_2d_area_entered(patron_2d_follow):
	var patron = patron_2d_follow.get_parent().patron
	attack(patron)
	
func get_path_follow_area_2d() -> Area2D:
	var path_follow_area_2d = get_node("PathFollowArea2D")
	assert(path_follow_area_2d != null, str("PathFollowArea2D must be set in ", monster_name, " scene"))
	return path_follow_area_2d


