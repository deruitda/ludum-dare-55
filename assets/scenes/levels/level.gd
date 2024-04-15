extends Node2D

@onready var summoning_portal = $SummoningPortal
@onready var free_moving_monsters = $FreeMovingMonsters
@onready var wave_container = $WaveContainer
@onready var paths_container = $PathsContainer

@export var first_path_segment: Path2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningState.reset_state()
	wave_container.start_waves()

func add_patron(patron_node):
	first_path_segment.add_child(patron_node)

func _process(delta):
	pass
