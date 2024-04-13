extends Node2D

@export var _patrons_allowed_to_survive = 10

@onready var patronsSurvived = 0
@onready var totalSouls = 0
@onready var currentSouls = 0


func _process(delta):
	pass
	#if (patronsSurvived >= _patrons_allowed_to_survive):
		#getNode("Main").gameOver()


func patronSurvived():
	patronsSurvived += 1
