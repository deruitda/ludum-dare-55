extends Path2D

@export var child_paths: Array[Path2D] = []
@export var is_ending_path: bool = false
func _ready():
	pass
	# SummoningSignal.connect("puzzle_solved", _on_puzzle_solved)
	# summoning_portal.visible = false
	# add_child(summoning_portal)
