extends Area2D

enum summoning_portal_states {
	POSITION_SELECTED,
	SELECTING_POSITION
}
@onready var summoning_portal_state = summoning_portal_states.SELECTING_POSITION
@onready var portal_animation = $PortalAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	SummoningSignal.connect("monster_summoned_canceled", reset_state)
	SummoningSignal.connect("state_changed", _on_summoning_state_changed)

func setPosition(new_position: Vector2):
	if summoning_portal_state == summoning_portal_states.SELECTING_POSITION:
		position = new_position

func setSummoningPosition():
	summoning_portal_state = summoning_portal_states.POSITION_SELECTED

func reset_state():
	summoning_portal_state = summoning_portal_states.SELECTING_POSITION
	hide_portal()
	
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
