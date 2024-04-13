extends PathFollow2D

@onready var path_follow = get_parent()
@export var _speed : float = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	path_follow.set_progress(path_follow.get_progress() + _speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
