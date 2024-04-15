extends Node2D

@export var monster_name: String = ""
@export var _speed: float = 0.0

@export var _max_souls_to_consume: int = 1
@export var _visual_resource: Resource
@export var puzzle_sets: Array[Resource] = []
@onready var puzzles: Array = []
@export var damage: int = 1
@onready var _number_of_souls_captured: int = 0

@onready var area_2d = $Area2D
@onready var attack_collision_shape = $Area2D/AttackCollisionShape
@onready var monster_animation = $Area2D/MonsterAnimation

@export var lock_to_path: bool = false
@export var choose_direction: bool = false

@onready var is_summoned: bool

const PUZZLE = preload("res://assets/scenes/monsters/puzzles/puzzle.tscn")

@onready var puzzle_objects: Array = []

@onready var puzzle_container: Node = Node.new()

func _ready():
	add_child(puzzle_container)
	setup_puzzle_objects()
	add_puzzles()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _number_of_souls_captured == _max_souls_to_consume:
		desummon()
	if is_summoned:
		is_summoned = false
		monster_animation.play("summoning")
		
func _physics_process(delta):
	pass

func set_summoned():
	is_summoned = true
	

func get_random_puzzle():
	if puzzle_container:
		return puzzle_container.get_children().pick_random()

func get_capacity_to_consume_souls() -> int:
	print("Soul capacity: ", str(_max_souls_to_consume - _number_of_souls_captured))
	return _max_souls_to_consume - _number_of_souls_captured

func attack(patron: Node2D):
	var num_of_souls_captured = 0
	if get_capacity_to_consume_souls() >= patron.health:
		print("Damage: " + str(damage))
		num_of_souls_captured = patron.capture_souls(damage)
		print("At capacity, captured souls: " + str(num_of_souls_captured))
	else:
		num_of_souls_captured = patron.capture_souls(get_capacity_to_consume_souls())
		print("Not at capacity, captured souls: " + str(num_of_souls_captured))
	_number_of_souls_captured += num_of_souls_captured
	SoulsCapturedSignal.emit_signal("souls_captured", num_of_souls_captured)

func desummon():
	monster_animation.play("desummoning")

func summon():
	monster_animation.play("summoning")

func destroy():
	get_parent().queue_free()

func _on_path_follow_area_2d_area_entered(patron_2d_follow):
	var patron = patron_2d_follow.get_parent().patron
	attack(patron)

func setup_puzzle_objects():
	for puzzle_set in puzzle_sets:
		var json = puzzle_set.get_data()
		puzzle_objects += json

# Concatenate arrays

func add_puzzle(puzzle: String, regex_answers: Array):
	var puzzle_node = PUZZLE.instantiate()
	puzzle_node.text_puzzle = puzzle
	for regex_answer in regex_answers:
		puzzle_node.regex_answers.append(regex_answer)
	if puzzle_container:
		puzzle_container.add_child(puzzle_node)
		

func add_puzzles():
	for puzzle in puzzle_objects:
		add_puzzle(puzzle["text_puzzle"], puzzle["regex_answers"])

func _on_summoning_animation_finished():
	monster_animation.play("idle")

func _on_animated_sprite_2d_animation_finished():
	if monster_animation.animation == "summoning":
		_on_summoning_animation_finished()
	elif monster_animation.animation == "desummoning":
		destroy()
