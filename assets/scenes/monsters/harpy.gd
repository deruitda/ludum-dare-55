extends "res://assets/scenes/npcs/monster.gd"
@onready var attack_node = $AttackNode

func _on_summoning_animation_finished():
	super()
	attack_node.start_attacking()


func _on_attack_node_attack():
	monster_animation.play("using_power")


func _on_attack_node_attack_finished():
	monster_animation.play("idle")
