extends Node

@export var _total_patrons_allowed_to_survive: int = 10
var souls_captured: int = 0 # Total number of souls captured throughout level
var souls_to_spend: int = 0 # Number of souls able to spend on summoning monsters
var souls_survived: int = 0 # If too many souls survive then it's game over
var remaining_patrons_allowed_to_survive: int
var is_paused: bool = false
var is_game_over: bool = false


func _ready():
	SurviveSignal.connect("patron_survived", on_patron_survived)
	SoulsCapturedSignal.connect("souls_captured", on_souls_captured)
	GameSignal.connect("game_paused", _on_game_paused)
	GameSignal.connect("game_resumed", _on_game_resumed)
	SummoningSignal.connect("monster_summoned", _on_monster_summoned)
	remaining_patrons_allowed_to_survive = _total_patrons_allowed_to_survive - souls_survived


func _on_monster_summoned(monster):
	print("Souls to spend: " + str(souls_to_spend))
	print("Monster soul cost:" + str(monster.soul_cost))
	souls_to_spend -= monster.soul_cost
	print("Remaining souls to spend: " + str(souls_to_spend))


func on_patron_survived(patron):
	souls_survived += patron.souls
	remaining_patrons_allowed_to_survive = _total_patrons_allowed_to_survive - souls_survived
	if remaining_patrons_allowed_to_survive <= 0:
		remaining_patrons_allowed_to_survive = 0
		is_game_over = true
		GameSignal.emit_signal("game_over")
	SurviveSignal.emit_signal("patron_survived_updated")


func on_souls_captured(num_of_souls_captured):
	souls_captured += num_of_souls_captured
	souls_to_spend += num_of_souls_captured
	SoulsCapturedSignal.emit_signal("souls_captured_updated")


func set_level(level):
	reset_souls()


func reset_souls():
	souls_captured = 0
	souls_survived = 0
	souls_to_spend = 0


func _on_game_paused():
	is_paused = true
	GameSignal.emit_signal("game_paused_updated")
	
func _on_game_resumed():
	is_paused = false
	GameSignal.emit_signal("game_paused_updated")
