extends Area2D

@onready var portal_animation = $PortalAnimation
@onready var paths_container = $"../PathsContainer"

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	SummoningSignal.connect("state_changed", _on_summoning_state_changed)
	SummoningSignal.connect("puzzle_solved", _on_puzzle_solved)

func _process(delta):
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:
		set_summoning_position()
		visible = true

func set_summoning_position():
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:

		var mouse_position = get_global_mouse_position() - global_position
		position = paths_container.get_closest_position_on_path(mouse_position)
		#if summon_monster().lock_to_path:
			#position = paths_container.get_closest_position(mouse_position)
		#else:
			#position = mouse_position

	
func show_portal():
	visible = true 

func hide_portal():
	visible = false
	
func _on_summoning_state_changed(state):
	if state == SummoningState.summoning_states.IDLE:
		hide_portal()
		portal_animation.stop()
	elif state == SummoningState.summoning_states.CHOOSING_LOCATION:
		show_portal()
		portal_animation.play("default")
	elif state == SummoningState.summoning_states.SUMMONING:
		show_portal()
		portal_animation.play("active")

func _on_puzzle_solved():
	summon_monster()

func summon_monster():
	var new_monster_path_follow_2d = SummoningState.summoning_monster.duplicate()
	new_monster_path_follow_2d.scale = Vector2(1, 1)
	new_monster_path_follow_2d.position = position
	paths_container.add_to_path(new_monster_path_follow_2d)
	#if new_monster_path_follow_2d.get_monster().lock_to_path:
		#get_parent().add_to_path(new_monster_path_follow_2d) 
	#else:
		#get_parent().add_monster_path_follow_2d_to_free_moving_monsters(new_monster_path_follow_2d)

	SummoningSignal.emit_signal("monster_summoned")
