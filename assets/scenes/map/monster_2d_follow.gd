extends PathFollow2D


@onready var monster = $Monster
@export var speed = 20.0
@onready var is_summoned: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_summoned:
		monster.set_summoned()
	loop = false


func get_monster():
	return monster

func set_summoned():
	is_summoned = true
