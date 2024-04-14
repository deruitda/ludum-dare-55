extends PathFollow2D
@onready var monster = $Monster
@export var speed = 20.0
# Called when the node enters the scene tree for the first time.
func _ready():
	loop = false

func get_monster():
	return monster
