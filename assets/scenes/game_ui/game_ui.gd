extends Control


@onready var pause_menu = %PauseMenu
@onready var game_over_menu = %GameOverMenu
@onready var day_complete_ui = $"Day Complete UI"
@onready var day_complete_timer = $"Day Complete UI/DayCompleteTimer"
@onready var day_complete_subtext = $"Day Complete UI/DayCompleteSubtext"

func _ready():
	GameSignal.connect("game_over", _on_game_over)
	GameSignal.connect("game_paused", _on_game_paused)
	GameSignal.connect("game_restarted", _on_game_restarted)
	GameSignal.connect("game_resumed", _on_game_resumed)
	GameSignal.connect("wave_updated", _on_wave_updated)
	
func _on_game_over():
	game_over_menu.visible = true

func _on_wave_updated(wave: int):
	day_complete_subtext.text = "Starting Day " + str(GameState.get_current_wave())
	day_complete_timer.start()
	day_complete_ui.visible = true
	
func _on_game_paused():
	pause_menu.visible = true


func _on_game_restarted():
	game_over_menu.visible = false
	pause_menu.visible = false

func _on_game_resumed():
	pause_menu.visible = false


func _on_day_complete_timer_timeout():
	day_complete_ui.visible = false
	GameSignal.emit_signal("day_complete_ui_closed")
	pass # Replace with function body.
