extends Control


func _on_new_game_button_pressed():
	GameSignal.emit_signal("new_game")


func _on_quit_button_pressed():
	GameSignal.emit_signal("game_quit")
