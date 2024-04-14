extends Area2D

enum summoning_portal_states {
	SELECTING_POSITION,
	POSITION_SELECTED
}
@onready var state = summoning_portal_states.SELECTING_POSITION
# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningSignal.connect("monster_summoned_canceled", reset_state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if SummoningState.current_state == SummoningState.summoning_states.IDLE:
		visible = false
	else:
		visible = true 
	pass

func setPosition(new_position: Vector2):
	if state == summoning_portal_states.SELECTING_POSITION:
		position = new_position

func setSummoningPosition():
	state = summoning_portal_states.POSITION_SELECTED

func reset_state():
	state = summoning_portal_states.SELECTING_POSITION
