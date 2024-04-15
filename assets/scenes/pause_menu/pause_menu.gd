extends Control


@onready var main_pause_menu = %MainPauseMenu
@onready var options_pause_menu = %OptionsPauseMenu


func _on_resume_pressed():
	GameSignal.emit_signal("game_resumed")


func _on_restart_pressed():
	GameSignal.emit_signal("game_restarted")


func _on_options_button_pressed():
	main_pause_menu.visible = false
	options_pause_menu.visible = true


func _on_quit_button_pressed():
	GameSignal.emit_signal("game_quit")


func _on_back_button_pressed():
	options_pause_menu.visible = false
	main_pause_menu.visible = true


func _input(event):
	if event.is_action_pressed("esc"):
		if GameState.is_game_over:
			pass
		elif GameState.is_paused:
			GameSignal.emit_signal("game_resumed")
		elif SummoningState.current_state == SummoningState.summoning_states.IDLE:
			GameSignal.emit_signal("game_paused")
		get_tree().get_root().set_input_as_handled()
