extends Node2D

@export var patron_class: String = ""
@export var souls = 1
@export var _total_health = 1
@export var speed = 100.0

@export var _visual_resource: Resource

@onready var health: int

func _ready():
	health = _total_health

func get_path_follow_area_2d() -> Area2D:
	var path_follow_area_2d = get_node("PathFollowArea2D")
	assert(path_follow_area_2d != null, str("PathFollowArea2D must be set in ", patron_class, " scene"))
	return path_follow_area_2d

func _on_path_follow_area_2d_area_entered(monster_2d_follow):
	var monster = monster_2d_follow.get_parent().monster
	monster.attack(self)
	if health <= 0:
		monster_2d_follow.queue_free()
		monster.queue_free()

func capture_souls(souls_to_capture: int)-> int:
	var total_damage = 0
	if health >= souls_to_capture:
		total_damage = souls_to_capture
	else:
		total_damage = health

	health -= total_damage
	if health <= 0:
		die()
	return total_damage

func die():
	queue_free()
