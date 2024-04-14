extends Node2D
@export var number_of_patrons: int = 0
@export var length_of_time_in_seconds: int = 0

@onready var number_of_patrons_spawned: int = 0
@onready var timers_completed: int = 0
const HUMAN_SCENE = preload("res://assets/scenes/patrons/human.tscn");
@onready var respawn_timer = $RespawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_timer.autostart = false
	respawn_timer.set_wait_time(get_seconds_per_respawn() * 1.0)
	print(respawn_timer.wait_time)
func start_wave():
	respawn_timer.start()

func get_seconds_per_respawn():
	return (length_of_time_in_seconds * 1.0) / (number_of_patrons * 1.0)

func _process(delta):
	if number_of_patrons_spawned == number_of_patrons:
		complete_wave()

func add_human():
	var human_node = HUMAN_SCENE.instantiate()
	get_parent().add_patron(human_node)
	number_of_patrons_spawned += 1

func _on_respawn_timer_timeout():
	timers_completed += 1
	if number_of_patrons_spawned < number_of_patrons:
		add_human()

func complete_wave():
	respawn_timer.stop()
	get_parent()._on_wave_complete()
