extends Node

var souls_captured: int = 0 # Total number of souls captured throughout level
var souls_to_spend: int = 0 # Number of souls able to spend on summoning monsters
var souls_survived: int = 0 # If too many souls survive then it's game over


func _ready():
	SurviveSignal.connect("patron_survived", on_patron_survived)
	SoulsCapturedSignal.connect("souls_captured", on_souls_captured)
	

func _process(delta):
	pass


func on_patron_survived(patron):
	souls_survived += patron.souls
	SurviveSignal.emit_signal("patron_survived_updated")


func on_souls_captured(patron):
	souls_captured += patron.souls
	souls_to_spend += patron.souls
	SoulsCapturedSignal.emit_signal("souls_captured_updated")


func set_level(level):
	reset_souls()


func reset_souls():
	souls_captured = 0
	souls_survived = 0
	souls_to_spend = 0


