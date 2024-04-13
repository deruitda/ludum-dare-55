extends Node

enum summoning_states {
	IDLE,
	CHOOSING_LOCATION,
	SUMMONING
}

@onready var current_state = summoning_states.IDLE
@onready var summoning_monster = null

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
	current_state = summoning_states.IDLE
	summoning_monster = null
	print("State reset")
	print("Current state: ", current_state)

func _on_monster_selected(monster):
	if current_state == summoning_states.IDLE:
		current_state = summoning_states.CHOOSING_LOCATION
		summoning_monster = monster
		print("Monster selected: ", monster)
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_location_selected():
	if current_state == summoning_states.CHOOSING_LOCATION:
		current_state = summoning_states.SUMMONING
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_monster_summoned_successfully():
	if current_state == summoning_states.SUMMONING:
		current_state = summoning_states.IDLE
		print("Monster summoned successfully")
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)

func _on_monster_summoned_failed():
	if current_state == summoning_states.SUMMONING:
		current_state = summoning_states.IDLE
		print("Monster summoning failed")
		print("Current state: ", current_state)
	else:
		print("Cannot summon monster, current state: ", current_state)
