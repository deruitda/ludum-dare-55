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
	SummoningSignal.connect("monster_summoned_successfully", _on_monster_summoned_successfully)
	SummoningSignal.connect("monster_summoned_failed", _on_monster_summoned_failed)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_state():
	summoning_monster = null
	set_state(summoning_states.IDLE)
	print("State reset")
	print("Current state: ", current_state)

func _on_monster_selected(monster):
	if current_state == summoning_states.IDLE:
		set_state(summoning_states.CHOOSING_LOCATION)
		summoning_monster = monster
		print("Monster selected: ", monster)
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_location_selected():
	if current_state == summoning_states.CHOOSING_LOCATION:
		set_state(summoning_states.SUMMONING)
		set_puzzle()
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_monster_summoned_successfully():
	if current_state == summoning_states.SUMMONING:
		set_state(summoning_states.IDLE)
		print("Monster summoned successfully")
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_monster_summoned_failed():
	if current_state == summoning_states.SUMMONING:
		set_state(summoning_states.IDLE)
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

#  The code is pretty simple. We have a state machine with three states: IDLE, CHOOSING_LOCATION, and SUMMONING. The state machine is controlled by the  set_state  function, which sets the current state to the one passed as an argument. 
#  The  _on_monster_selected  function is called when a monster is selected. If the current state is IDLE, the state is set to CHOOSING_LOCATION, and the monster is saved in the  summoning_monster  variable. 
#  The  _on_location_selected  function is called when a location is selected. If the current state is CHOOSING_LOCATION, the state is set to SUMMONING. 
#  The  _on_monster_summoned_successfully  function is called when the monster is summoned successfully. If the current state is SUMMONING, the state is set to IDLE. 
#  The  _on_monster_summoned_failed  function is called when the monster summoning fails. If the current state is SUMMONING, the state is set to IDLE. 
#  The  reset_state  function is used to reset the state machine to the IDLE state. 
#  The  _on_monster_selected ,  _on_location_selected ,  _on_monster_summoned_successfully , and  _on_monster_summoned_failed  functions print the current state of the state machine. 
#  Now, let’s create the signals that will be used to communicate between the different nodes. 
#  Create the signals 
#  In the  SummoningSignal  script, add the following code: 
#  extends Node
