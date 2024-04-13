extends Node
const Monster = preload("res://assets/scenes/monsters/monster.gd")
@export var monster: Node2D = null
@export var summon_monster_input_action_number: int = 1
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = monster._visual_resource
	pass # Replace with function body.


		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input_action()
	pass
	
func check_input_action():
	match summon_monster_input_action_number:
		1:
			if Input.is_action_pressed("select_monster_1"):
				begin_summoning_monster()
		2:
			if Input.is_action_pressed("select_monster_2"):
				begin_summoning_monster()
		3:
			if Input.is_action_pressed("select_monster_3"):
				begin_summoning_monster()
		
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		begin_summoning_monster()
		

func begin_summoning_monster():
	pass
