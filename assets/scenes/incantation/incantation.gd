extends Control

@onready var line_edit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("puzzle_set", _on_puzzle_set)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	if SummoningState.current_puzzle.does_answer_solve_puzzle(new_text):
		SummoningSignal.emit_signal("puzzle_solved")
		incantation_success()
	else:
		incantation_failed()
		
	line_edit.clear()

func _on_puzzle_set():
	line_edit.grab_focus()
	
func incantation_success():
	# TODO: Play sound, show animation
	print("Incantation Success")


func incantation_failed():
	# TODO: Play sound, show animation
	print("Incantation Failed")


func _on_line_edit_focus_exited():
	SummoningSignal.emit_signal("monster_summoned_canceled")
	line_edit.clear()
