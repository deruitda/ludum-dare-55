extends Node2D
@export var number_or_patrons_per_second: float = 0
@export var total_wave_length_in_seconds: int = 0

@onready var number_of_patrons_spawned: int = 0
const HUMAN_SCENE = preload("res://assets/scenes/patrons/human.tscn");
@onready var respawn_timer = $RespawnTimer
@onready var wave_complete_timer = $WaveCompleteTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_timer.autostart = false
	respawn_timer.set_wait_time(get_seconds_per_respawn())
	wave_complete_timer.set_wait_time(total_wave_length_in_seconds)
	print(respawn_timer.wait_time)
	# print(wave_complete_timer.wait_time)
	
func start_wave():
	wave_complete_timer.start()
	respawn_timer.start()

func get_number_of_patrons():
	return number_or_patrons_per_second * total_wave_length_in_seconds

func get_seconds_per_respawn() -> float:
	return 1.0 / number_or_patrons_per_second

func add_human():
	var human_node = HUMAN_SCENE.instantiate()
	get_parent().add_patron(human_node)
	number_of_patrons_spawned += 1

func _on_respawn_timer_timeout():
	add_human()

func complete_wave():
	respawn_timer.stop()
	get_parent()._on_wave_complete()


func _on_wave_complete_timer_timeout():
	complete_wave()
