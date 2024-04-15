extends Node2D

@export var souls = 1
@export var _total_health = 1
@export var speed = 100.0

@onready var currently_dying: bool = false
@onready var health: int

@onready var animated_sprite_2d = $PathFollowArea2D/AnimatedSprite2D
@onready var death_sound = $DeathSound

@onready var death_animation_finished: bool = false
@onready var death_sound_finished: bool = false

@onready var death_sound_container = $DeathSoundContainer

func _ready():
	health = _total_health
	
func _process(delta):
	if health <= 0 and currently_dying == false:
		trigger_death()

func _on_path_follow_area_2d_area_entered(monster_area):
	var monster = monster_area.get_parent()
	monster.attack(self)

func capture_souls(souls_to_capture: int)-> int:
	var total_damage = 0
	if health >= souls_to_capture:
		total_damage = souls_to_capture
	else:
		total_damage = health
	health -= total_damage
	return total_damage

func trigger_death():
	death_sound.stream = death_sound_container.get_random_stream()
	death_sound.play()
	currently_dying = true
	animated_sprite_2d.play("dying")
	

func destroy():
	if death_sound_finished and death_animation_finished:
		get_parent().queue_free()
	
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "dying":
		death_animation_finished = true
		destroy()

func _on_death_sound_finished():
	death_sound_finished = true
	destroy()
