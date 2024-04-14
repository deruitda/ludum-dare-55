extends "res://assets/scenes/npcs/monster.gd"
const PUZZLE = preload("res://assets/scenes/npcs/resources/puzzle.tscn")


@onready var monster_animation = $"../PathFollowArea2D/AnimatedSprite2D"
# Load JSON files and concatenate arrays
# var command_word_puzzles = loadJsonFileToArray("res://assets/scenes/npcs/resources/puzzle_sets/command_word_puzzles.json")
# var backword_word_puzzles = loadJsonFileToArray("res://assets/scenes/npcs/resources/puzzle_sets/backword_word_puzzles.json")
# var latin_chants = loadJsonFileToArray("res://assets/scenes/npcs/resources/puzzle_sets/latin_chants.json")
# var short_summoning_incantations = loadJsonFileToArray("res://assets/scenes/npcs/resources/puzzle_sets/short_summoning_incantations.json")
# var long_summoning_incantations = loadJsonFileToArray("res://assets/scenes/npcs/resources/puzzle_sets/long_summoning_incantations.json")

@onready var puzzle_objects: Array = []

func _ready():
	print("Summoning Lost Soul")
	setup_puzzle_objects()
	add_puzzles()

func setup_puzzle_objects():
	for puzzle_set in puzzle_sets:
		var json = puzzle_set.get_data()
		puzzle_objects += json

func loadJsonFileToArray(file_path: String) -> Array:
	var json_as_text = FileAccess.get_file_as_string(file_path)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		return json_as_dict
	return []


# Concatenate arrays

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

func desummon():
	monster_animation.play("desummoning")

func _on_animated_sprite_2d_animation_finished():
	print("Lost Soul Animation finished: " + monster_animation.animation)
	if monster_animation.animation == "summoning":
		monster_animation.play("idle")
		print("Playing idle Soul")
	elif monster_animation.animation == "desummoning":
		destroy()
