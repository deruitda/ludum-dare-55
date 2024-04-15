extends Control


func _on_restart_pressed():
	GameSignal.emit_signal("game_restarted")


func _on_quit_button_pressed():
	GameSignal.emit_signal("game_quit")


func _input(event):
	print("input event in pause menu")
	if event.is_action_pressed("esc"):
		print("esc hit")
		if GameState.is_game_over:
			print("game is over, cannot resume")
			pass
		elif GameState.is_paused:
			print("resuming game")
			GameSignal.emit_signal("game_resumed")
		elif SummoningState.current_state == SummoningState.summoning_states.IDLE:
			print("pausing game")
			GameSignal.emit_signal("game_paused")
		get_tree().get_root().set_input_as_handled()
