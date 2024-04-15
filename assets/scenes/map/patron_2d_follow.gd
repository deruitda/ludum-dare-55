extends PathFollow2D

@export var speed = 100.0
@onready var patron = $Patron
@onready var human = $Human

func _ready():
	loop = false

func _physics_process(delta):
	if !patron.currently_dying:
		set_progress(get_progress() + (patron.speed * delta))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_progress_ratio() == 1.0:
		get_parent().reached_the_end(self)
		
func patron_survived():
	SurviveSignal.emit_signal("patron_survived", patron)
	queue_free()
