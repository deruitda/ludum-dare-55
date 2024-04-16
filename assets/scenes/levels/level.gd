extends Node2D

@onready var summoning_portal = $SummoningPortal
@onready var free_moving_monsters = $FreeMovingMonsters
@onready var wave_container = $WaveContainer
@onready var paths_container = $PathsContainer
@onready var wave_cooldown = $WaveCooldown


@onready var current_wave: int = 1

const WAVE = preload("res://assets/scenes/levels/wave.tscn")


@export var first_path_segment: Path2D
# Called when the node enters the scene tree for the first time.
func _ready():
	SummoningState.reset_state()
	wave_container.start_waves()
	GameSignal.connect("day_complete_ui_closed", _on_day_complete_ui_closed)

func add_patron(patron_node):
	first_path_segment.add_child(patron_node)
	
func _process(delta):
	pass
	
func _on_wave_container_wave_complete():
	desummon_all_monsters()
	GameSignal.emit_signal("wave_completed")
	

func start_next_wave():
	wave_container.start_waves()

func open_wave_cooldown_hud():
	pass

func _on_day_complete_ui_closed():
	start_next_wave()

func desummon_all_monsters():
	for monster_node in free_moving_monsters.get_children():
		monster_node.queue_free()
	paths_container.desummon_all_monsters()
