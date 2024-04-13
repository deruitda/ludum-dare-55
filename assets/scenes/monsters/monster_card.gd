extends Node
const Monster = preload("res://assets/scenes/monsters/monster.gd")
@export var monster: Node2D = null
@export var summon_monster_input_action_number: int = 1
@onready var sprite_2d = $Area2D/Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var area_2d = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = monster._visual_resource
	var sprite_width = sprite_2d.texture.get_width()
	var sprite_height = sprite_2d.texture.get_height()
	sprite_2d.offset = Vector2(sprite_width / -2, sprite_height / -2)
	
	var sprite_size = sprite_2d.texture.get_size()
	var rect_shape = RectangleShape2D.new()
	rect_shape.extents = sprite_size / 2
	collision_shape_2d.shape = rect_shape



		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input_action()
	pass
	
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
	SummoningSignal.emit_signal("monster_selected", monster)
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		begin_summoning_monster()
