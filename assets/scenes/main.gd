extends Node2D

@onready var current_level = $CurrentLevel

@onready var current_level_index = 0
@onready var status = "playing"

const LEVELS = [
	"res://assets/scenes/levels/level_1.tscn"
	
]
func _ready():
	SurviveSignal.connect("patron_survived", on_patron_survived)
	var scene = load(LEVELS[current_level_index])
	current_level.get_tree().change_scene_to_packed(scene)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_patron_survived(patron):
	var souls_captured = patron.souls

func gameOver():
	status = "gameOver"
