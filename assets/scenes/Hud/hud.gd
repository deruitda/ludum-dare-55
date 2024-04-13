extends HBoxContainer

@export var _patrons_allowed_to_survive = 10


@onready var totalSouls = 0
@onready var currentSouls = 0

func _ready(): 
	SurviveSignal.connect("patron_survived_updated", updated_patron_survived_hud)
	updated_patron_survived_hud()


func updated_patron_survived_hud():
	$PatronsSurvivedLabel.text = "Survivors: " + str(GameState.souls_survived)
