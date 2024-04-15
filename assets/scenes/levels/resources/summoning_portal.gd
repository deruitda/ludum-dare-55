extends Area2D

@onready var portal_animation = $PortalAnimation
@onready var paths_container = $"../PathsContainer"
@onready var summoning_mouse_position_threshold: float = 100.0
@onready var free_moving_monsters = $"../FreeMovingMonsters"
@onready var direction_line = $DirectionLine

@export var direction_line_length: float = 1000000.0
@export var threshold_length: float = 100.0

@onready var mouse_is_over_threshold = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	SummoningSignal.connect("state_changed", _on_summoning_state_changed)
	SummoningSignal.connect("puzzle_solved", _on_puzzle_solved)

func set_summoning_position(summon_monster_position):
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:
		var monster = get_monster()
		if monster.lock_to_path:
			var potential_path_position = paths_container.get_closest_position_on_path(summon_monster_position)
			if summon_monster_position.distance_to(potential_path_position) > threshold_length:
				mouse_is_over_threshold = true
				hide_portal()
			else:
				mouse_is_over_threshold = false
				position = potential_path_position
				show_portal()
		else:
			mouse_is_over_threshold = false
			show_portal()
			position = summon_monster_position

	
func show_portal():
	visible = true 

func hide_portal():
	visible = false
	
func show_line():
	direction_line.visible = true

func hide_line():
	direction_line.visible = false

func _on_summoning_state_changed(state):
	if state == SummoningState.summoning_states.IDLE:
		hide_portal()
		hide_line()
		portal_animation.stop()
	elif state == SummoningState.summoning_states.CHOOSING_LOCATION:
		show_portal()
		hide_line()
		portal_animation.play("default")
	elif state == SummoningState.summoning_states.CHOOSING_DIRECTION:
		show_portal()
		show_line()
	elif state == SummoningState.summoning_states.SUMMONING:
		show_portal()
		portal_animation.play("active")

func _on_puzzle_solved():
	summon_monster()

func get_monster():
	return get_summoning_monster_path_follow_2d().get_monster()
	
func get_summoning_monster_path_follow_2d():
	return SummoningState.summoning_monster

func get_direction_line_direction():
	return (direction_line.get_point_position(1) - direction_line.get_point_position(0)).normalized()

func summon_monster():
	var monster = get_monster()
	if monster.lock_to_path == false:
		var new_monster = monster.duplicate()
		if monster.choose_direction:
			var running_direction = get_direction_line_direction()
			new_monster.running_direction = get_direction_line_direction()
		new_monster.position = position
		free_moving_monsters.add_child(new_monster)
	else:
		var new_monster_path_follow_2d = get_summoning_monster_path_follow_2d().duplicate()
		new_monster_path_follow_2d.scale = Vector2(1, 1)
		new_monster_path_follow_2d.position = position
		paths_container.add_to_path(new_monster_path_follow_2d)
	SummoningSignal.emit_signal("monster_summoned")

func set_direction_line_position(mouse_position: Vector2):
	var normalized_direction = (mouse_position - position).normalized()
	direction_line.set_point_position(1, (normalized_direction * direction_line_length))

func _input(event):
	var is_event_mouse_button_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	var is_event_mouse_motion = event is InputEventMouseMotion
	var is_choosing_location = SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION
	var is_choosing_direction = SummoningState.current_state == SummoningState.summoning_states.CHOOSING_DIRECTION

	if !is_event_mouse_button_click and !is_event_mouse_motion:
		return 
	
	if is_choosing_location:
		set_summoning_position(event.position)
		if is_event_mouse_button_click and (mouse_is_over_threshold == false or get_monster().lock_to_path == false):
			SummoningSignal.emit_signal("location_selected")
	
	
	if is_choosing_direction:
		set_direction_line_position(event.position)
		if event is InputEventMouseButton:
			SummoningSignal.emit_signal("direction_selected")
