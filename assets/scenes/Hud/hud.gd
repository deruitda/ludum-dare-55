extends Control

var play_button_texture = preload("res://assets/sprites/misc/icons/play.png")
var pause_button_texture = preload("res://assets/sprites/misc/icons/pause.png")

@onready var health_bar = %HealthBar
@onready var health_bar_text = %PatronsSurvivedLabel
@onready var souls_text = %Souls
@onready var pause_button = %PauseButton
@onready var pause_menu = %PauseMenu

@export var _total_patrons_allowed_to_survive = 100

func _ready(): 
	SurviveSignal.connect("patron_survived_updated", updated_patron_survived_hud)
	SoulsCapturedSignal.connect("souls_captured_updated", _on_souls_captured_updated)


func updated_patron_survived_hud():
	health_bar.value = 100 * GameState.remaining_patrons_allowed_to_survive / GameState.total_patrons_allowed_to_survive
	health_bar_text.text = str(GameState.remaining_patrons_allowed_to_survive) + " Survivors Remaining"


func _on_souls_captured_updated():
	souls_text.text = str(GameState.souls_captured)
	

func _on_pause_button_pressed():
	print("Pause button clicked, game is paused " + str(GameState.is_paused))
	if GameState.is_paused:
		# Game is paused, resume the game
		GameSignal.emit_signal("game_resumed")
		pause_menu.visible = false
		pause_button.texture_normal = pause_button_texture
	else:
		# Game is playing, pause the game
		GameSignal.emit_signal("game_paused")
		pause_menu.visible = true
		pause_button.texture_normal = play_button_texture
