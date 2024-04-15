extends Control

@onready var line_edit = $LineEdit
@onready var timer = %Timer
@export var _speaking_animation_wait_time: int = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("location_selected", _on_location_selected)


func _on_line_edit_text_submitted(new_text):
	if SummoningState.current_state == SummoningState.summoning_states.SUMMONING:
		if SummoningState.current_puzzle.does_answer_solve_puzzle(new_text):
			incantation_success()
		else:
			incantation_failed()
		line_edit.clear()


func _on_location_selected():
	line_edit.grab_focus()
	
	
func incantation_success():
	SummoningSignal.emit_signal("puzzle_solved")
	line_edit.clear()
	# TODO: Play sound, show animation


func incantation_failed():
	# TODO: Play sound, show animation
	print("Incantation Failed")


func _on_line_edit_focus_exited():
	if SummoningState.current_state == SummoningState.summoning_states.SUMMONING:
		SummoningSignal.emit_signal("monster_summoned_canceled")
		line_edit.clear()


func _on_line_edit_gui_input(event):
	if SummoningState.current_state == SummoningState.summoning_states.SUMMONING:
		if (!SummoningState.is_incantation_typing):
			SummoningSignal.emit_signal("incantation_typing")
		_start_timer()


func _start_timer():
	timer.wait_time = _speaking_animation_wait_time
	timer.start()


func _on_timer_timeout():
	timer.stop()
	SummoningSignal.emit_signal("incantation_stopped_typing")
