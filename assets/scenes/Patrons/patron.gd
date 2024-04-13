extends PathFollow2D

@onready var path_follow = get_parent()

@export var souls = 1
@export var health = 1
@export var speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	set_progress(get_progress() + (speed * delta))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
