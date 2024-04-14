extends Node2D

@onready var level = get_parent()
@onready var current_wave_index = 0
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
