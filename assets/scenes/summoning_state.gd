extends Node

enum summoning_states {
	IDLE,
	CHOOSING_LOCATION,
	CHOOSING_DIRECTION,
	SAYING_INCANTATION,
	SUMMONING
}

@onready var current_state = summoning_states.IDLE
@onready var summoning_monster = null
@onready var current_puzzle = null
@onready var is_incantation_typing = false

@onready var is_summoning_monster_animation = false
# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("monster_selected", _on_monster_selected)
	SummoningSignal.connect("location_selected", _on_location_selected)
	SummoningSignal.connect("direction_selected", _on_direction_selected)
	SummoningSignal.connect("monster_summoned", _on_monster_summoned)
	SummoningSignal.connect("monster_summoned_canceled", _on_monster_summoned_canceled)
	SummoningSignal.connect("monster_summoned_failed", _on_monster_summoned_failed)
	SummoningSignal.connect("incantation_typing", _on_incantation_typing)
	SummoningSignal.connect("incantation_stopped_typing", _on_incantation_stopped_typing)
	SummoningSignal.connect("summoning_animation_finished", _on_summoning_animation_finished)
	SummoningSignal.connect("puzzle_solved", _on_puzzle_solved)

func reset_state():
	summoning_monster = null
	set_state(summoning_states.IDLE)
	current_puzzle = null

func _on_puzzle_solved():
	set_state(summoning_states.SUMMONING)

func _on_monster_selected(monster):
	if current_state == summoning_states.IDLE:
		set_state(summoning_states.CHOOSING_LOCATION)
		summoning_monster = monster
	else:
		print("Cannot summon monster, current state: ", current_state)


func _on_location_selected():
	if current_state == summoning_states.CHOOSING_LOCATION:
		if get_monster().choose_direction:
			set_state(summoning_states.CHOOSING_DIRECTION)
		else:
			set_state(summoning_states.SAYING_INCANTATION)
			set_puzzle()

func _on_direction_selected():
	if current_state == summoning_states.CHOOSING_DIRECTION:
		set_state(summoning_states.SAYING_INCANTATION)
		set_puzzle()

func get_monster():
	return get_summoning_monster_path_follow_2d().get_monster()
	
func get_summoning_monster_path_follow_2d():
	return summoning_monster

func _on_monster_summoned(_monster):
	reset_state()
	


func _on_monster_summoned_canceled():
	reset_state()
	print("Monster summoning canceled")


func _on_monster_summoned_failed():
	if current_state == summoning_states.SAYING_INCANTATION:
		reset_state()
		print("Monster summoning failed")
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)


func set_state(state):
	current_state = state
	SummoningSignal.emit_signal("state_changed", current_state)
 

func set_puzzle():
	current_puzzle = summoning_monster.monster.get_random_puzzle()
	print("text puzzle")
	print(current_puzzle.text_puzzle)
	SummoningSignal.emit_signal("puzzle_set")

func lock_to_path():
	return summoning_monster.monster.lock_to_path()

func _input(event):
	if event.is_action_pressed("ui_cancel") and current_state != summoning_states.IDLE:
		SummoningSignal.emit_signal("monster_summoned_canceled")

func _on_incantation_typing():
	is_incantation_typing = true
	SummoningSignal.emit_signal("incantation_typing_updated")
	
func _on_incantation_stopped_typing():
	is_incantation_typing = false
	SummoningSignal.emit_signal("incantation_typing_updated")

func _on_summoning_animation_finished():
	set_state(summoning_states.IDLE)
