extends Node2D

const PATRONS_ALLOWED_TO_SURVIVE = 10

@onready var patronsSurvived = 0
@onready var totalSouls = 0
@onready var currentSouls = 0


func _process(delta):
	if (patronsSurvived >= PATRONS_ALLOWED_TO_SURVIVE):
		getNode("Main").gameOver()


func patronSurvived():
	patronsSurvived += 1
