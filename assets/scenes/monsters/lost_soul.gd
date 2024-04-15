extends "res://assets/scenes/npcs/monster.gd"
@onready var summoning_sound = $SummoningSound
@onready var desummoning_sound = $DesummoningSound

func summon():
	super()
	summoning_sound.play()
	
func desummon():
	super()
	desummoning_sound.play()
