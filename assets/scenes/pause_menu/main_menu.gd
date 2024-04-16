extends Control


@onready var audio_player = %AudioStreamPlayer
@onready var hades_animation = %HadesAnimation
@onready var new_game_button = %NewGameButton
@onready var is_playing_hades_audio = false
var selected_level_index = 0


const HADES_FRUSTRATION_AUDIOS = [
	"res://assets/audio/misc/hades/HadesFrustration1.wav",
	"res://assets/audio/misc/hades/HadesFrustration2.wav",
	"res://assets/audio/misc/hades/HadesFrustration3.wav",
	"res://assets/audio/misc/hades/HadesFrustration4.wav",
	"res://assets/audio/misc/hades/HadesFrustration5.wav",
	"res://assets/audio/misc/hades/HadesFrustration6.wav",
	"res://assets/audio/misc/hades/HadesFrustration7.wav"
]


func _ready():
	GameSignal.connect("tutorial_stopped", _on_tutorial_stopped)

func _on_hard_button_pressed():
	start_new_game(2)

func _on_medium_button_pressed():
	start_new_game(1)

func _on_easy_button_pressed():
	start_new_game(0)

func start_new_game(levelIndex):
	if !is_playing_hades_audio:
		selected_level_index = levelIndex
		is_playing_hades_audio = true
		toggle_buttons()
		hades_animation.play("speaking")
		play_random_hades_frustration_audio()


func _on_quit_button_pressed():
	GameSignal.emit_signal("game_quit")


func play_random_hades_frustration_audio():
	var picked_audio = HADES_FRUSTRATION_AUDIOS.pick_random()
	audio_player.stream = load(picked_audio)
	audio_player.play()


func _on_audio_stream_player_finished():
	is_playing_hades_audio = false
	toggle_buttons()
	GameSignal.emit_signal("new_game", selected_level_index)
	


func _on_tutorial_pressed():
	$Tutorial.visible = true
	$Tutorial/VideoStreamPlayer.play()
	GameSignal.emit_signal("tutorial_started")
	
func _on_tutorial_stopped():
	$Tutorial.visible = false
	$Tutorial/VideoStreamPlayer.stop()
	
func toggle_buttons():
	%EasyButton.disabled = !%EasyButton.disabled
	%Medium.disabled = !%Medium.disabled
	%Hard.disabled = !%Hard.disabled
