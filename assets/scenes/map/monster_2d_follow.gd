extends PathFollow2D

@export var monster: Node2D = null
@onready var sprite_2d = $Sprite2D

@onready var path_follow = get_parent()

@export var speed = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = monster._visual_resource
	loop = false
