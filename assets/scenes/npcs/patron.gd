extends Node2D

@export var patron_class: String = ""
@export var souls = 1
@export var _total_health = 1
@export var speed = 100.0

@export var _visual_resource: Resource

@onready var health: int

func _ready():
	health = _total_health
	print(str(health)+ " vs " + str(_total_health))
	
func _process(delta):
	if health <= 0:
		die()

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
	print("souls_to_capture: " + str(souls_to_capture))
	var total_damage = 0
	print("health: " + str(health))
	if health >= souls_to_capture:
		total_damage = souls_to_capture
	else:
		total_damage = health
	health -= total_damage
	print("total damage" + str(total_damage))
	return total_damage

func die():
	queue_free()
