extends PathFollow2D

@export var speed = 100.0
@onready var patron = $Patron

func _ready():
	loop = false

func _physics_process(delta):
	set_progress(get_progress() + (patron.speed * delta))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_progress_ratio())
	if get_progress_ratio() == 1.0:
		get_parent().reached_the_end(self)
		
func patron_survived():
	SurviveSignal.emit_signal("patron_survived", patron)
	queue_free()
	
func patron_died():
	SoulsCapturedSignal.emit_signal("patron_died", patron)

func _on_path_follow_area_2d_area_entered(area):
	pass # Replace with function body.
