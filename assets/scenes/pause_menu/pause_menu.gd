extends Control


func _on_restart_pressed():
	GameSignal.emit_signal("game_restarted")


func _on_quit_button_pressed():
	GameSignal.emit_signal("game_quit")
