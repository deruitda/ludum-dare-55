extends Node2D
@export var number_of_patrons: int = 0
@export var length_of_time_in_seconds: int = 0

@onready var number_of_patrons_spawned: int = 0
const HUMAN_SCENE = preload("res://assets/scenes/patrons/human.tscn");
@onready var respawn_timer = $RespawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	respawn_timer.autostart = false
	respawn_timer.wait_time = get_seconds_per_respawn()
	# respawn_timer.start()
func start_wave():
	respawn_timer.start()

func get_seconds_per_respawn():
	return length_of_time_in_seconds / number_of_patrons

func _process(delta):
	pass


func _on_respawn_timer_timeout():
	var human_node = HUMAN_SCENE.instantiate()
	get_parent().add_patron(human_node)
