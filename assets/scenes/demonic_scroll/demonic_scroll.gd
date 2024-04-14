extends Control


@onready var scroll_animation = $ScrollAnimation
@onready var puzzle_text = $PuzzleText


func _ready():
	SummoningSignal.connect("puzzle_set", _on_puzzle_set)
	SummoningSignal.connect("state_changed", _on_state_changed)


func _process(delta):
	pass


func _on_puzzle_set():
	scroll_animation.play("scroll_opening")
	puzzle_text.text = SummoningState.current_puzzle.text_puzzle


func _on_state_changed(new_state):
	if new_state == SummoningState.summoning_states.IDLE:
		puzzle_text.text = ""
		scroll_animation.play("scroll_closing")
