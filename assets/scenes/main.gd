extends Node2D


@onready var current_level = 1
@onready var status = "playing"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gameOver():
	status = "gameOver"