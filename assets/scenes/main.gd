extends Node2D


@onready var current_level = %CurrentLevel
@onready var current_level_scene = null
@onready var current_level_index = 0
@onready var audio_player = %AudioStreamPlayer
@onready var main_menu = %MainMenu


const LEVELS = [
	"res://assets/scenes/levels/level_1.tscn"
]

const BG_SONGS = [
	"res://assets/audio/background_music/A Haunting.wav",
	"res://assets/audio/background_music/Drop Dead.wav",
	"res://assets/audio/background_music/HeartThumper2.wav",
	"res://assets/audio/background_music/Overstimulate.wav",
	"res://assets/audio/background_music/Transylvania.wav"
]

func _ready():
	GameSignal.connect("game_paused_updated", _on_game_paused_updated)
	GameSignal.connect("game_over", _on_game_over)
	GameSignal.connect("game_restarted", _on_game_restarted)
	GameSignal.connect("game_resumed", _on_game_resumed)
	GameSignal.connect("game_quit", _on_game_quit)
	GameSignal.connect("new_game", _on_new_game)
	GameSignal.connect("game_to_main_menu", _on_game_to_main_menu)
	main_menu.visible = false
	load_current_level_scene()
	get_new_background_song()


func _input(event):
	if event.is_action_pressed("esc"):
		if GameState.is_game_over:
			pass
		elif GameState.is_paused:
			GameSignal.emit_signal("game_resumed")
		elif SummoningState.current_state == SummoningState.summoning_states.IDLE:
			GameSignal.emit_signal("game_paused")


func _on_game_paused_updated():
	if GameState.is_paused:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_game_over():
	get_tree().paused = true


func _on_game_quit():
	get_tree().quit()


func _on_game_resumed():
	get_tree().paused = false


func _on_game_restarted():
	get_tree().paused = false
	remove_current_level_scene()
	load_current_level_scene()
	get_new_background_song()


func _on_game_to_main_menu():
	if current_level_scene != null:
		remove_current_level_scene()
	get_tree().paused = false
	main_menu.visible = true


func _on_new_game():
	if current_level_scene != null:
		remove_current_level_scene()
	get_tree().paused = false
	main_menu.visible = false
	load_current_level_scene()


func load_current_level_scene():
	var new_scene = load(LEVELS[current_level_index]).instantiate()
	current_level_scene = new_scene
	current_level.add_child(new_scene)


func remove_current_level_scene():
	current_level.remove_child(current_level_scene)
	current_level_scene = null


func get_new_background_song():
	var song = BG_SONGS.pick_random()
	audio_player.stream = load(song)
	audio_player.play()
