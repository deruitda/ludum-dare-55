extends Node2D
signal wave_complete

@export var wave_intensity_percentage_increase: float = 0.1

@onready var level = get_parent()
@onready var current_wave_index = 0
@onready var waves_complete: bool = false

@onready var initial_patron_respawn_cooldown_in_seconds: float = 5
@onready var initial_wave_length_in_seconds: float = 30

@onready var number_of_souls_captured_at_wave_start: int = 0
@onready var number_of_souls_survived_at_wave_start: int = 0

@onready var total_number_of_patrons: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SoulsCapturedSignal.connect("souls_captured_updated", check_wave_complete_status)
	SurviveSignal.connect("patron_survived_updated", check_wave_complete_status)

func get_current_wave():
	return get_children()[current_wave_index]

func start_waves():
	reset_state()
	start_wave()
	
func start_wave():
	get_current_wave().start_wave((GameState.get_current_wave() - 1) * wave_intensity_percentage_increase)
	total_number_of_patrons += get_current_wave().get_number_of_patrons()
	
func reset_state():
	current_wave_index = 0
	waves_complete = false
	number_of_souls_captured_at_wave_start = GameState.souls_captured
	number_of_souls_survived_at_wave_start = GameState.souls_survived
	total_number_of_patrons = 0
	
func add_patron(patron):
	get_parent().add_patron(patron)

func _on_wave_complete():
	current_wave_index += 1
	if current_wave_index < get_child_count():
		start_wave()
	elif waves_complete == false:
		waves_complete = true
		print ('waves completed patron spawning')

func check_wave_complete_status():
	if waves_complete and GameState.souls_captured + GameState.souls_survived == number_of_souls_captured_at_wave_start + number_of_souls_survived_at_wave_start + total_number_of_patrons:
		emit_signal("wave_complete")



func _on_wave_wave_complete():
	pass # Replace with function body.
