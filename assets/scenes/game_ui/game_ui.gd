extends Control


@onready var pause_menu = %PauseMenu
@onready var game_over_menu = %GameOverMenu

func _ready():
	GameSignal.connect("game_over", _on_game_over)
	GameSignal.connect("game_paused", _on_game_paused)
	GameSignal.connect("game_restarted", _on_game_restarted)
	GameSignal.connect("game_resumed", _on_game_resumed)

func _on_game_over():
	print("Showing game over menu")
	game_over_menu.visible = true


func _on_game_paused():
	pause_menu.visible = true


func _on_game_restarted():
	game_over_menu.visible = false
	pause_menu.visible = false


func _on_game_resumed():
	print("hiding paused menu due to resume")
	pause_menu.visible = false
