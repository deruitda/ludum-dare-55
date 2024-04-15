extends Node2D


func _on_restart_button_pressed():
	GameSignal.emit_signal("game_restarted")
