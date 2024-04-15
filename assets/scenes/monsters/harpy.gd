extends "res://assets/scenes/npcs/monster.gd"


@onready var attack_node = $AttackNode
@export var stun_percentage: float = 80.0
@export var stun_duration_in_seconds: float = 5.0
@export var stun_radius: float = 100.0

@onready var radius_container = $Area2D/RadiusContainer
@onready var radius_sprite = $Area2D/RadiusContainer/RadiusSprite

func _on_summoning_animation_finished():
	super()
	attack_node.attack_radius = stun_radius
	attack_node.start_attacking()

func _on_attack_node_attack():
	attack_node.visible = true
	attack_collision_shape.shape.radius = stun_radius
	monster_animation.play("using_power")
	

func _on_attack_node_attack_finished():
	attack_collision_shape.shape.radius = 0.0
	monster_animation.play("idle")

func attack(patron):
	if attack_node.currently_attacking:
		patron.set_stun(stun_percentage, stun_duration_in_seconds)

func _ready():
	super()
	radius_container.visible = false
	attack_node.set_attack_radius(stun_radius)
	set_radius_container()

func set_radius_container():
	const radius_pixels = 100.0
	var radius_scale = stun_radius / radius_pixels
	radius_container.scale.x = radius_scale
	radius_container.scale.y = radius_scale
