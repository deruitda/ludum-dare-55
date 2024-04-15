extends Node2D

@onready var summoning_portal = $SummoningPortal
@onready var free_moving_monsters = $FreeMovingMonsters
@onready var wave_container = $WaveContainer
@onready var paths_container = $PathsContainer


@onready var current_wave: int = 1

const WAVE = preload("res://assets/scenes/levels/wave.tscn")


@export var first_path_segment: Path2D
# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningState.reset_state()
	wave_container.start_waves()

func add_patron(patron_node):
	first_path_segment.add_child(patron_node)
	
func _process(delta):
	pass
	
func _on_wave_container_wave_complete():
	GameState.increment_wave()
	wave_container.start_waves()
	print('wave ' + str(GameState.get_current_wave()))

