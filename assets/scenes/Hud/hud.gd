extends Control


var play_button_texture = preload("res://assets/sprites/misc/icons/play.png")
var pause_button_texture = preload("res://assets/sprites/misc/icons/pause.png")


@onready var health_bar = %HealthBar
@onready var health_bar_text = %PatronsSurvivedLabel
@onready var souls_text = %Souls
@onready var pause_button = %PauseButton


func _ready(): 
	SurviveSignal.connect("patron_survived_updated", updated_patron_survived_hud)
	SoulsCapturedSignal.connect("souls_captured_updated", _on_souls_captured_updated)
	GameSignal.connect("game_paused", _on_game_paused)
	GameSignal.connect("game_resumed", _on_game_resumed)
	health_bar_text.text = str(GameState.remaining_patrons_allowed_to_survive) + " Survivors Remaining"


func updated_patron_survived_hud():
	health_bar.value = 100 * GameState.remaining_patrons_allowed_to_survive / GameState._total_patrons_allowed_to_survive
	health_bar_text.text = str(GameState.remaining_patrons_allowed_to_survive) + " Survivors Remaining"


func _on_souls_captured_updated():
	souls_text.text = str(GameState.souls_captured)


func _on_game_paused():
	set_play_button()


func _on_game_resumed():
	print("on game resumed in hud")
	set_pause_button()


func _on_pause_button_pressed():
	if GameState.is_game_over:
		pass
	elif GameState.is_paused:
		# Game is paused, resume the game
		GameSignal.emit_signal("game_resumed")
		set_pause_button()
	else:
		# Game is playing, pause the game
		GameSignal.emit_signal("game_paused")
		set_play_button()
	get_tree().get_root().set_input_as_handled()


func set_play_button():
	print("setting play button")
	pause_button.texture_normal = play_button_texture


func set_pause_button():
	print("setting pause button")
	pause_button.texture_normal = pause_button_texture
