extends Node
const Monster = preload("res://assets/scenes/monsters/monster.gd")
@export var monster: Node2D = null
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = monster._visual_resource
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
