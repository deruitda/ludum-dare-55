extends Button

const Monster = preload("res://assets/scenes/npcs/monster.gd")

@export var monster: Node2D = Monster.new()
@export var summon_monster_input_action_number: int = 1

@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("state_changed", _on_state_changed)

func _process(delta):
	check_input_action()

func check_input_action():
	match summon_monster_input_action_number:
		1:
			if Input.is_action_just_pressed("select_monster_1"):
				attempt_to_summon_monster()
		2:
			if Input.is_action_just_pressed("select_monster_2"):
				attempt_to_summon_monster()
		3:
			if Input.is_action_just_pressed("select_monster_3"):
				attempt_to_summon_monster()

func _on_pressed():
	audio_stream_player.play()
	if SummoningState.current_state == SummoningState.summoning_states.IDLE:
		attempt_to_summon_monster()
	else:
		end_summoning_monster()
		
# Check if player has captured enough souls to spend on the monster
func attempt_to_summon_monster():
	var monster_soul_cost = monster.soul_cost
	if monster_soul_cost <= GameState.souls_to_spend:
		begin_summoning_monster()
	else:
		print("Cannot afford monster")
	

func begin_summoning_monster():
	$BorderActive.visible = true
	SummoningSignal.emit_signal("monster_selected", monster)

func end_summoning_monster():
	$BorderActive.visible = false

func _on_state_changed(new_state):
	if new_state == SummoningState.summoning_states.IDLE:
		end_summoning_monster()
