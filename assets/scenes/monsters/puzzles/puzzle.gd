extends Node2D

@onready var text_puzzle: String = ""
@onready var regex_answers: Array[String] = [] 

func does_answer_solve_puzzle(potential_answer: String) -> bool:
	return check_answer(potential_answer)

func check_answer(potential_answer: String) -> bool:
	for answer in regex_answers:
		if checkRegex(potential_answer, answer):
			return true
	return false

func checkRegex(input_string: String, pattern: String) -> bool:
	var regex = RegEx.new()  # Create a new RegEx object
	regex.compile(pattern)  # Compile the regex pattern

	# Check if the input string matches the regex pattern
	if regex.search(input_string.to_lower()):
		return true
	else:
		return false
