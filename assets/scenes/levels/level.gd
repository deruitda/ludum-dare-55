extends Node2D

const PATRON_2D_FOLLOW = preload("res://assets/scenes/map/patron_2d_follow.tscn")
const MONSTER_2D_FOLLOW = preload("res://assets/scenes/map/monster_2d_follow.tscn")
const HUMAN_SCENE = preload("res://assets/scenes/patrons/human.tscn");

@onready var paths_container = $PathsContainer
@onready var summoning_mouse_position_threshold: float = 100.0
@onready var summoning_portal = $SummoningPortal
@onready var closest_path_to_summoning_portal: Node2D = null

@export var waves: Array[Node2D] = []
@export var first_path_segment: Path2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningState.reset_state()

	SummoningSignal.connect("puzzle_solved", _on_puzzle_solved)
	add_human()

func _on_timer_timeout():
	pass
	# add_human()
	
func summon_monster():
	var new_monster = SummoningState.summoning_monster.duplicate()
	new_monster.set_progress(closest_path_to_summoning_portal.curve.get_closest_offset(summoning_portal.position))
	closest_path_to_summoning_portal.add_child(new_monster)
	SummoningSignal.emit_signal("monster_summoned")

func add_human():
	var human_node = HUMAN_SCENE.instantiate()
	first_path_segment.add_child(human_node)
	
func _process(delta):
	setSummoningPortal()
	pass

func add_summoning_portal_to_position(position):
	summoning_portal.setPosition(position)

func _on_puzzle_solved():
	summon_monster()
	summoning_portal.reset_state()
	
func setSummoningPortal():
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:

		var mouse_position = get_global_mouse_position() - global_position
		closest_path_to_summoning_portal = paths_container.get_closest_path(mouse_position)
		var closest_point = closest_path_to_summoning_portal.curve.get_closest_point(mouse_position)


		if mouse_position.distance_to(closest_point) <= summoning_mouse_position_threshold:
			add_summoning_portal_to_position(closest_point)


func _input(event):
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				summoning_portal.setSummoningPosition()
				SummoningSignal.emit_signal("location_selected")
