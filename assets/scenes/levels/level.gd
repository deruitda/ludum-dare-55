extends Node2D
@export var waves: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningState.reset_state()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass