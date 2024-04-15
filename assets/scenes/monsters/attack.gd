extends Node

signal attack
signal attack_finished
signal area_entered(area)

@export var attack_time_in_seconds: float = 0.25
@export var cooldown_in_seconds: float = 4.0

@onready var attack_radius: float = 1.0

@onready var attack_timer = $AttackTimer
@onready var attack_cooldown_timer = $AttackCooldownTimer
@onready var anim = $AnimatedSprite2D
@onready var attack_node_activated: bool = false
@onready var can_attack: bool = false
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var currently_attacking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attack_node_activated == false and can_attack == true:
		attack_node_activated = true
		make_attack()
	set_animated_sprite_radius()

func start_attacking():
	can_attack = true

func make_attack():
	currently_attacking = true
	animated_sprite_2d.visible = true
	attack_timer.start(attack_time_in_seconds)
	anim.play("attack")
	attack.emit()
	
func revoke_attack():
	currently_attacking = false
	animated_sprite_2d.visible = false
	attack_finished.emit()
	attack_cooldown_timer.start(cooldown_in_seconds)


func _on_attack_timer_timeout():
	attack_timer.stop()
	anim.play("nothing")
	revoke_attack()

func _on_attack_cooldown_timer_timeout():
	attack_cooldown_timer.stop()
	make_attack()


func _on_attack_area_area_entered(area):
	area_entered.emit(area)
	
func set_attack_radius(new_attack_radius: float):
	attack_radius = new_attack_radius
	set_animated_sprite_radius()

func set_animated_sprite_radius():
	var sprite_radius_in_pixels = 50.0 #derived from pixel art
	var sprite_attack_scale = attack_radius / sprite_radius_in_pixels
	animated_sprite_2d.scale.x = sprite_attack_scale 
	animated_sprite_2d.scale.y = sprite_attack_scale 
