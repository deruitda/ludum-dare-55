extends Node2D

@onready var current_level = $GameControl/CurrentLevel

@onready var current_level_index = 0
@onready var status = "playing"


const LEVELS = [
	"res://assets/scenes/levels/level_1.tscn"
	
]
func _ready():
	var scene = load(LEVELS[current_level_index]).instantiate()
	current_level.add_child(scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gameOver():
	status = "gameOver"
