extends "res://assets/scenes/npcs/monster.gd"
@onready var summoning_sound = $SummoningSound
@onready var desummoning_sound = $DesummoningSound
@onready var attack_cooldown = $AttackCooldown
@onready var attack_sound = $AttackSound

@onready var attack_is_cooling_down: bool = false

func summon():
	super()
	summoning_sound.play()
	
func desummon():
	super()
	desummoning_sound.play()

func attack(patron: Node2D):
	if attack_is_cooling_down:
		return
	else:
		attack_is_cooling_down = true
		attack_sound.play()
		attack_cooldown.start()
		monster_animation.play("attacking")
		super(patron)

func _on_animated_sprite_2d_animation_finished():
	if monster_animation.animation == "attacking":
		if attack_is_cooling_down:
			monster_animation.play("cooldown")
		else:
			monster_animation.play("idle")


func _on_attack_cooldown_timeout():
	if is_desummoning:
		return
	attack_is_cooling_down = false
	monster_animation.play("idle")
