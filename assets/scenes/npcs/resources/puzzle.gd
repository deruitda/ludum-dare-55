extends Node2D

@export var text_puzzle: String = ""
@export var regex_answers: Array[String] = [] 

func does_answer_solve_puzzle(potential_answer: String) -> bool:
	# TODO: Check that puzzle is actually solved
	return true
