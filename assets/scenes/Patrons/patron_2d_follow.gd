extends PathFollow2D

const Patron = preload("res://assets/scenes/patrons/patron.gd")
@export var patron: Node2D = null
@onready var sprite_2d = $Sprite2D

@onready var path_follow = get_parent()

@export var souls = 1
@export var health = 1
@export var speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = patron._visual_resource
	loop = false

func _physics_process(delta):
	set_progress(get_progress() + (speed * delta))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_progress_ratio() == 1.0:
		patron_survived()
		
func patron_survived():
	SurviveSignal.emit_signal("patron_survived", self)
	queue_free()
	
func patron_died():
	DeathSignal.emit_signal("patron_died", self)
	
