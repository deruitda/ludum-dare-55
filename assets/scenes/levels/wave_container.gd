extends Node2D

@onready var level = get_parent()
@onready var current_wave_index = 0
@onready var waves_complete: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_current_wave():
	return get_children()[current_wave_index]

func start_waves():
	get_current_wave().start_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_patron(patron):
	get_parent().add_patron(patron)

func _on_wave_complete():
	current_wave_index += 1
	if current_wave_index < get_child_count():
		get_current_wave().start_wave()
	elif waves_complete == false:
		waves_complete = true
		print("Waves have finished")
