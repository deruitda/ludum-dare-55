extends Control


@onready var score_text = %Score
@onready var days_label = $VBoxContainer2/DaysLabel


func _ready():
	GameSignal.connect("game_over", _on_game_over)


func _on_restart_button_pressed():
	GameSignal.emit_signal("game_restarted")


func _on_quit_button_pressed():
	GameSignal.emit_signal("game_quit")


func _on_game_over():
	score_text.text = str(GameState.souls_captured)
	days_label.text = str(GameState.get_current_wave())


func _on_main_menu_button_pressed():
	GameSignal.emit_signal("game_to_main_menu")

