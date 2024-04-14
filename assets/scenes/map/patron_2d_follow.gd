extends PathFollow2D

@export var patron: Node2D = null
@export var speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
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
	
func add_patron(new_patron):
	patron = new_patron
	var path_follow_area_2d = patron.get_path_follow_area_2d()
	print (patron.path_follow_area_2d)
	patron.remove_child(path_follow_area_2d)
	add_child(path_follow_area_2d)
