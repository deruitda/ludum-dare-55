extends Path2D

const PATRON_2D_FOLLOW = preload("res://assets/scenes/map/patron_2d_follow.tscn")
const MONSTER_2D_FOLLOW = preload("res://assets/scenes/map/monster_2d_follow.tscn")
@onready var human_scene = preload("res://assets/scenes/Patrons/human.tscn")

const SUMMONING_PORTAL = preload("res://assets/scenes/levels/resources/summoning_portal.tscn")

@onready var summoning_mouse_position_threshold: float = 100.0
@onready var summoning_portal: Node2D = SUMMONING_PORTAL.instantiate()

func _ready():
	SummoningSignal.connect("puzzle_solved", _on_puzzle_solved)
	summoning_portal.visible = false
	add_child(summoning_portal)


func _on_timer_timeout():
	# pass
	add_human()
	
func _process(delta):
	setSummoningPortal()

func add_summoning_portal_to_position(position):
	summoning_portal.setPosition(position)
	summoning_portal.visible = true

func _input(event):
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				summoning_portal.setSummoningPosition()
				SummoningSignal.emit_signal("location_selected")

func setSummoningPortal():
	if SummoningState.current_state == SummoningState.summoning_states.CHOOSING_LOCATION:
		var mouse_position = get_global_mouse_position() - global_position
		var closest_point_to_mouse = curve.get_closest_point(mouse_position)
		if mouse_position.distance_to(closest_point_to_mouse) <= summoning_mouse_position_threshold:
			add_summoning_portal_to_position(closest_point_to_mouse)
		else:
			summoning_portal.visible = false
	elif SummoningState.current_state != SummoningState.summoning_states.SUMMONING:
		summoning_portal.visible = false

func summon_monster():
	var new_monster = MONSTER_2D_FOLLOW.instantiate()
	new_monster.monster = SummoningState.summoning_monster
	print (SummoningState.summoning_monster)
	new_monster.set_progress(curve.get_closest_offset(summoning_portal.position))
	add_child(new_monster)
	SummoningSignal.emit_signal("monster_summoned")

func add_human():
	var new_patron_2d_follow = PATRON_2D_FOLLOW.instantiate()
	var new_human = human_scene.instantiate()
	new_patron_2d_follow.add_patron(new_human)
	add_child(new_patron_2d_follow)
	
func _on_puzzle_solved():
	summon_monster()
	summoning_portal.reset_state()
	summoning_portal.visible = false
	
