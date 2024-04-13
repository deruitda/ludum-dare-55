extends Node2D

@export var _patrons_allowed_to_survive = 10


@onready var totalSouls = 0
@onready var currentSouls = 0

func _ready(): 
	SurviveSignal.connect("patron_survived_updated", patronSurvived)
	$PatronsSurvivedLabel.text = "Survivors: 100"


func patronSurvived():
	$PatronsSurvivedLabel.text = "Survivors: " + str(GameState.souls_survived)
