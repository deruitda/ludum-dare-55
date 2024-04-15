extends Node2D


@onready var current_level = %CurrentLevel
@onready var current_level_scene = null
@onready var current_level_index = 0


const LEVELS = [
	"res://assets/scenes/levels/level_1.tscn"
]


func _ready():
	GameSignal.connect("game_paused_updated", _on_game_paused_updated)
	GameSignal.connect("game_over", _on_game_over)
	GameSignal.connect("game_restarted", _on_game_restarted)
	GameSignal.connect("game_quit", _on_game_quit)
	load_current_level_scene()
	
	
func _on_game_paused_updated():
	if GameState.is_paused:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_game_over():
	get_tree().paused = true


func _on_game_quit():
	get_tree().quit()


func _on_game_restarted():
	get_tree().paused = false
	remove_current_level_scene()
	load_current_level_scene()


func load_current_level_scene():
	current_level_scene = load(LEVELS[current_level_index]).instantiate()
	current_level.add_child(current_level_scene)


func remove_current_level_scene():
	current_level.remove_child(current_level_scene)
