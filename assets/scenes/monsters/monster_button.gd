extends Button

const Monster = preload("res://assets/scenes/npcs/monster.gd")

@export var monster: Node2D = Monster.new()
@export var summon_monster_input_action_number: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	monster.scale = Vector2(.8, .8)
	add_child(monster)

func _process(delta):
	check_input_action()

func check_input_action():
	match summon_monster_input_action_number:
		1:
			if Input.is_action_just_pressed("select_monster_1"):
				begin_summoning_monster()
		2:
			if Input.is_action_just_pressed("select_monster_2"):
				begin_summoning_monster()
		3:
			if Input.is_action_just_pressed("select_monster_3"):
				begin_summoning_monster()

func begin_summoning_monster():
	$BorderActive.visible = true
	SummoningSignal.emit_signal("monster_selected", monster)


func _on_pressed():
	begin_summoning_monster()
