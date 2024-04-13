extends Node

var souls_captured: int = 0 # Total number of souls captured throughout level
var current_soul_count: int = 0 # Number of souls able to spend on summoning monsters
var souls_survived: int = 0 # If too many souls survive then it's game over

# Called when the node enters the scene tree for the first time.
func _ready():
	SurviveSignal.connect("patron_survived", on_patron_survived)
	DeathSignal.connect("patron_died", on_patron_died)

func on_patron_survived(patron):
	souls_survived += patron.souls
	SurviveSignal.emit_signal("patron_survived_updated")
	
func on_patron_died(patron):
	souls_captured += patron.souls
	current_soul_count += patron.souls
	
func set_level(level):
	reset_souls()

func reset_souls():
	souls_captured = 0
	souls_survived = 0
	current_soul_count = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
