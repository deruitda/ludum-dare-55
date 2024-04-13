extends Node2D

@export var _patrons_allowed_to_survive = 10

@onready var patronsSurvived = 0
@onready var totalSouls = 0
@onready var currentSouls = 0

func _ready(): 
	$PatronsSurvivedLabel.text = "Survivors: 100"


func patronSurvived():
	patronsSurvived += 1
	$PatronsSurvivedLabel.text = "Survivors: " + str(patronsSurvived)
