extends Node2D
@export var number_of_patrons: int = 0
@export var length_of_time_in_seconds: int = 0

@onready var initial_number_of_patrons_spawned: int = 0
@onready var timers_completed: int = 0
@onready var respawn_timer = $RespawnTimer

@onready var number_of_souls_captured_at_wave_start: int = 0
@onready var number_of_souls_survived_at_wave_start: int = 0

@onready var initial_number_of_patrons_spawned: int = 0

const HUMAN_SCENE = preload("res://assets/scenes/patrons/human.tscn");

signal wave_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_state()

func reset_state():
	respawn_timer.autostart = false
	respawn_timer.set_wait_time(get_seconds_per_respawn() * 1.0)

	number_of_souls_captured_at_wave_start = GameState.souls_captured
	number_of_souls_survived_at_wave_start = GameState.souls_survived	

func start_wave(intensity_percentage_increase: float):
	respawn_timer.start()
	number_of_patrons = initial_number_of_patrons_spawned + int(initial_number_of_patrons_spawned * intensity_percentage_increase)

func get_seconds_per_respawn():
	return (length_of_time_in_seconds * 1.0) / (number_of_patrons * 1.0)

func _process(delta):
	if number_of_patrons_spawned == number_of_patrons:
		stop_timer()

func add_human():
	var human_node = HUMAN_SCENE.instantiate()
	get_parent().add_patron(human_node)
	number_of_patrons_spawned += 1

func _on_respawn_timer_timeout():
	timers_completed += 1
	if number_of_patrons_spawned < number_of_patrons:
		add_human()

func stop_timer():
	respawn_timer.stop()

func complete_wave():
	emit_signal("wave_complete")

func get_number_of_patrons():
	return number_of_patrons
