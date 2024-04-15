extends Node2D


@onready var current_level = %CurrentLevel
@onready var current_level_index = 0


const LEVELS = [
	"res://assets/scenes/levels/level_1.tscn"
]


func _ready():
	GameSignal.connect("game_paused_updated", _on_game_paused_updated)
	GameSignal.connect("game_over", _on_game_over)
	GameSignal.connect("game_restarted", _on_game_restarted)
	var scene = load(LEVELS[current_level_index]).instantiate()
	current_level.add_child(scene)
	
	
func _on_game_paused_updated():
	if GameState.is_paused:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_game_over():
	get_tree().paused = true


func _on_game_restarted():
	get_tree().paused = false
