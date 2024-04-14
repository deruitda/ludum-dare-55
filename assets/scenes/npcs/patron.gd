extends Node2D

@export var patron_class: String = ""
@export var souls = 1
@export var _total_health = 1
@export var speed = 100.0

@export var _visual_resource: Resource

@onready var health: int
@onready var patron_path_follow_2d = $".."

func _ready():
	health = _total_health
	
func _process(delta):
	if health <= 0:
		die()

func _on_path_follow_area_2d_area_entered(monster_2d_follow):
	var monster = monster_2d_follow.get_parent().monster
	monster.attack(self)

func capture_souls(souls_to_capture: int)-> int:
	var total_damage = 0
	if health >= souls_to_capture:
		total_damage = souls_to_capture
	else:
		total_damage = health
	health -= total_damage
	return total_damage

func die():
	patron_path_follow_2d.queue_free()
