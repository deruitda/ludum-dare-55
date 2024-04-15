extends Node2D

@onready var current_level = %CurrentLevel
@onready var pause_menu = %PauseMenu

@onready var current_level_index = 0
@onready var status = "playing"


const LEVELS = [
	"res://assets/scenes/levels/level_1.tscn"
]

func _ready():
	GameSignal.connect("game_paused_updated", _on_game_paused_updated)
	var scene = load(LEVELS[current_level_index]).instantiate()
	current_level.add_child(scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gameOver():
	status = "gameOver"
	
func _on_game_paused_updated():
	if GameState.is_paused:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_play_button_pressed():
	GameSignal.emit_signal("game_resumed")
