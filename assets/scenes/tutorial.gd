extends Node2D

func _on_pressed():
	GameSignal.emit_signal("tutorial_stopped")
