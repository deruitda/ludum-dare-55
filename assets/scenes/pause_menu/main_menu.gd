extends Control


@onready var audio_player = %AudioStreamPlayer
@onready var hades_animation = %HadesAnimation
@onready var new_game_button = %NewGameButton
@onready var is_playing_hades_audio = false


const HADES_FRUSTRATION_AUDIOS = [
	"res://assets/audio/misc/hades/HadesFrustration1.wav",
	"res://assets/audio/misc/hades/HadesFrustration2.wav",
	"res://assets/audio/misc/hades/HadesFrustration3.wav",
	"res://assets/audio/misc/hades/HadesFrustration4.wav",
	"res://assets/audio/misc/hades/HadesFrustration5.wav",
	"res://assets/audio/misc/hades/HadesFrustration6.wav",
	"res://assets/audio/misc/hades/HadesFrustration7.wav"
]


func _on_new_game_button_pressed():
	if !is_playing_hades_audio:
		is_playing_hades_audio = true
		new_game_button.disabled = true
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
	new_game_button.disabled = false
	GameSignal.emit_signal("new_game")
