extends "res://assets/scenes/npcs/monster.gd"
@onready var attack_node = $AttackNode
@onready var radius_sprite = $Area2D/radius
@export var stun_percentage: float = 80.0
@export var stun_duration_in_seconds: float = 5.0

func _on_summoning_animation_finished():
	super()
	radius_sprite.visible = false
	attack_node.start_attacking()

func _on_attack_node_attack():
	$Area2D.visible = true
	monster_animation.play("using_power")

func _on_attack_node_attack_finished():
	$Area2D.visible = false
	monster_animation.play("idle")

func attack(patron):
	patron.set_stun(stun_percentage, stun_duration_in_seconds)
