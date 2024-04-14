extends "res://assets/scenes/npcs/monster.gd"
const PUZZLE = preload("res://assets/scenes/npcs/resources/puzzle.tscn")

# Called when the node enters the scene tree for the first time.
const puzzle_objects = [
	{
		"text_puzzle": "↑ ← →",
		"regex_answers": ["^wad$"]
	},
	{
		"text_puzzle": "↑ → ↑",
		"regex_answers": ["^wdw$"]
	},
	{
		"text_puzzle": "↑ ← → ←",
		"regex_answers": ["^wadw$"]
	},
	{
		"text_puzzle": "↑ → ←",
		"regex_answers": ["^wda$"]
	},
	{
		"text_puzzle": "↑ → ← ↑",
		"regex_answers": ["^wdaw$"]
	},
	{
		"text_puzzle": "↑ ← → ←",
		"regex_answers": ["^wada$"]
	},
	{
		"text_puzzle": "↑ → ← →",
		"regex_answers": ["^wdad$"]
	},
	{
		"text_puzzle": "↑ → ← → ↑",
		"regex_answers": ["^wdadw$"]
	},
];

func _ready():
	add_puzzles()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_puzzle(puzzle: String, regex_answers: Array):

	var puzzle_node = PUZZLE.instantiate()
	puzzle_node.text_puzzle = puzzle
	for regex_answer in regex_answers:
		puzzle_node.regex_answers.append(regex_answer)
	get_tree().root.add_child(puzzle_node)
	puzzles.append(puzzle_node)

func add_puzzles():
	for puzzle in puzzle_objects:
		add_puzzle(puzzle["text_puzzle"], puzzle["regex_answers"])
