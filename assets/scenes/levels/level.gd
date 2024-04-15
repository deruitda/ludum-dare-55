extends Node2D

@onready var summoning_portal = $SummoningPortal
@onready var free_moving_monsters = $FreeMovingMonsters
@onready var wave_container = $WaveContainer
@onready var paths_container = $PathsContainer

@export var initial_patron_respawn_cooldown_in_seconds = 2.0
@export var initial_wave_length_in_seconds = 30


const WAVE = preload("res://assets/scenes/levels/wave.tscn")


@export var first_path_segment: Path2D
# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningState.reset_state()
	wave_container.instantiate_inital_fields(initial_patron_respawn_cooldown_in_seconds, initial_wave_length_in_seconds)
	wave_container.start_waves()
func add_patron(patron_node):
	first_path_segment.add_child(patron_node)
	
func _process(delta):
	pass


func _on_wave_container_wave_complete():
	print('wave fully completed')
