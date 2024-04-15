extends Button

const Monster = preload("res://assets/scenes/npcs/monster.gd")

@export var monster: Node2D = Monster.new()
@export var summon_monster_input_action_number: int = 1

@onready var audio_stream_player = $AudioStreamPlayer
@onready var soul_cost_text = %SoulCost
@onready var error_timer = %ErrorTimer
@onready var monster_soul_cost = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("state_changed", _on_state_changed)
	SummoningSignal.connect("monster_selected_updated", _on_monster_selected_updated)
	GameSignal.connect("souls_to_spend_updated", _on_souls_to_spend_updated)
	monster_soul_cost = monster.get_monster().soul_cost
	soul_cost_text.text = str(monster_soul_cost)
	set_souls_cost_styling()

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
	print("Pressed Monster Button")
	attempt_to_summon_monster()

# Check if player has captured enough souls to spend on the monster
func attempt_to_summon_monster():
	audio_stream_player.play()
	if monster_soul_cost <= GameState.souls_to_spend:
		# Can afford monster
		SummoningSignal.emit_signal("monster_selected", monster)

func end_summoning_monster():
	set_default_styling()

func set_selected_styling():
	$BorderActive.visible = true

func set_default_styling():
	$BorderActive.visible = false

func _on_state_changed(new_state):
	if new_state == SummoningState.summoning_states.IDLE:
		end_summoning_monster()

func _on_monster_selected_updated():
	print("Monster selected updated: " + SummoningState.get_monster().monster_name + " - " + monster.get_monster().monster_name)
	if SummoningState.get_monster().monster_name == monster.get_monster().monster_name:
		set_selected_styling()
	else:
		set_default_styling()

func _on_souls_to_spend_updated():
	set_souls_cost_styling()

func set_souls_cost_styling():
	if monster_soul_cost > GameState.souls_to_spend:
		cannot_afford_monster_styling()
	else:
		reset_styling()

func cannot_afford_monster_styling():
	disabled = true
	soul_cost_text.modulate = Color(1, 0, 0)

func reset_styling():
	disabled = false
	soul_cost_text.modulate = Color(1, 1, 1)

func _on_error_timer_timeout():
	reset_styling()
