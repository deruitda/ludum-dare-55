extends Node

enum summoning_states {
	IDLE,
	CHOOSING_LOCATION,
	SUMMONING
}

@onready var current_state = summoning_states.IDLE
@onready var summoning_monster = null
@onready var current_puzzle = null

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("monster_selected", _on_monster_selected)
	SummoningSignal.connect("location_selected", _on_location_selected)
	SummoningSignal.connect("monster_summoned", _on_monster_summoned)
	SummoningSignal.connect("monster_summoned_failed", _on_monster_summoned_failed)
	SummoningSignal.connect("puzzle_set", _temp_on_puzzle_set)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_state():
	summoning_monster = null
	set_state(summoning_states.IDLE)
	current_puzzle = null
	print("State reset")
	print("Current state: ", current_state)

func _on_monster_selected(monster):
	if current_state == summoning_states.IDLE:
		set_state(summoning_states.CHOOSING_LOCATION)
		summoning_monster = monster
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_location_selected():
	if current_state == summoning_states.CHOOSING_LOCATION:
		set_state(summoning_states.SUMMONING)
		set_puzzle()
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_monster_summoned():
	reset_state()

func _on_monster_summoned_failed():
	if current_state == summoning_states.SUMMONING:
		set_state(summoning_states.IDLE)
		summoning_monster = null
		current_puzzle = null
		print("Monster summoning failed")
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func set_state(state):
	current_state = state
	SummoningSignal.emit_signal("state_changed", current_state)
	print("Current state: ", current_state)
 
func set_puzzle():
	current_puzzle = summoning_monster.get_random_puzzle()
	SummoningSignal.emit_signal("puzzle_set")

func _temp_on_puzzle_set():
	SummoningSignal.emit_signal("puzzle_solved")
