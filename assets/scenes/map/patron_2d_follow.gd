extends PathFollow2D

@export var patron: Node2D = null
@onready var sprite_2d = $Sprite2D

@onready var path_follow = get_parent()

@export var speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = patron._visual_resource
	loop = false

func _physics_process(delta):
	set_progress(get_progress() + (patron.speed * delta))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_progress_ratio() == 1.0:
		patron_survived()
		
func patron_survived():
	SurviveSignal.emit_signal("patron_survived", patron)
	queue_free()
	
func patron_died():
	SoulsCapturedSignal.emit_signal("patron_died", patron)
	
