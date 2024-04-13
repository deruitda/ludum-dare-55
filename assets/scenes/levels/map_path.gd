extends Path2D

const HUMAN_SCENE = preload("res://assets/scenes/Patrons/human.tscn");
const SUMMONING_POSITION = preload("res://assets/scenes/levels/resources/SummoningPosition.tscn")

@onready var summoning_mouse_position_threshold: float = 100.0

@onready var summoning_portal: Node2D = SUMMONING_POSITION.instantiate()

func add_human():
	var new_human = HUMAN_SCENE.instantiate()
	add_child(new_human)
	
	summoning_portal.visible = false
	add_child(summoning_portal)

func _on_timer_timeout():
	add_human()
	

func _process(delta):
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:
		var mouse_position = get_global_mouse_position() - global_position
		var closest_point_to_mouse = curve.get_closest_point(mouse_position)
		if mouse_position.distance_to(closest_point_to_mouse) <= summoning_mouse_position_threshold:
			add_summoning_portal_to_position(closest_point_to_mouse)
		else:
			summoning_portal.visible = false
	else:
		summoning_portal.visible = false

func add_summoning_portal_to_position(position):
	summoning_portal.position = position
	summoning_portal.visible = true
