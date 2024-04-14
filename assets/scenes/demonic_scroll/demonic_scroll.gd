extends Control


func _ready():
	SummoningSignal.connect("puzzle_set", _on_puzzle_set)


func _process(delta):
	pass


func _on_puzzle_set():
	pass
	#$PuzzleText.text = SummoningState.current_puzzle.text_puzzle
