extends Control

@onready var health_bar = $HealthBar
@onready var health_bar_text = $HealthBar/PatronsSurvivedLabel
@onready var souls_text = $Souls

@export var _total_patrons_allowed_to_survive = 100

func _ready(): 
	SurviveSignal.connect("patron_survived_updated", updated_patron_survived_hud)
	SoulsCapturedSignal.connect("souls_captured_updated", _on_souls_captured_updated)


func updated_patron_survived_hud():
	var remaining_patrons_allowed_to_survive = _total_patrons_allowed_to_survive - GameState.souls_survived
	if remaining_patrons_allowed_to_survive < 0:
		remaining_patrons_allowed_to_survive = 0
	health_bar.value = 100 * remaining_patrons_allowed_to_survive / _total_patrons_allowed_to_survive
	health_bar_text.text = str(remaining_patrons_allowed_to_survive) + " Survivors Remaining"


func _on_souls_captured_updated():
	souls_text.text = "Souls: " + str(GameState.souls_captured)
	
