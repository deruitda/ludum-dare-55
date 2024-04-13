extends Path2D

const HUMAN_SCENE = preload("res://assets/scenes/Patrons/human.tscn");



func add_human():
	var new_human = HUMAN_SCENE.instantiate()
	add_child(new_human)

func _on_timer_timeout():
	add_human()
