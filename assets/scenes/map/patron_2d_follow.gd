extends PathFollow2D

@export var speed = 100.0
@onready var patron = $Patron

@onready var stunned_effect_timer = $Patron/StunnedEffectTimer
@onready var stun_percentage: float = 0.0

func _ready():
	loop = false

func _physics_process(delta):
	if !patron.currently_dying:
		var walk_speed = (patron.speed * delta)
		if stun_percentage > 0.0:
			walk_speed *= 1 - (stun_percentage/100)
		set_progress(get_progress() + walk_speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_progress_ratio() == 1.0:
		get_parent().reached_the_end(self)
		
func patron_survived():
	SurviveSignal.emit_signal("patron_survived", patron)
	queue_free()

func set_stun(new_stun_percentage: float, stun_duration_in_seconds: float):
	stun_percentage = new_stun_percentage
	stunned_effect_timer.start(stun_duration_in_seconds)


func _on_stunned_effect_timer_timeout():
	stunned_effect_timer.stop()
	stun_percentage = 0.0
	pass # Replace with function body.
