extends Control

@onready var line_edit = $LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("location_selected", _on_location_selected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	if SummoningState.current_puzzle == SummoningState.summoning_states.SUMMONING:
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
		
		var new_text = line_edit.text
		if SummoningState.current_puzzle.does_answer_solve_puzzle(new_text):
			incantation_success()

