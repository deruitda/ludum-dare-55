extends "res://assets/scenes/npcs/monster.gd"

@onready var is_running: bool = false
@onready var running_direction: Vector2
@onready var charging_up_audio = $Area2D/MonsterAnimation/ChargingUpAudio

func set_running_direction(direction: Vector2):
	running_direction = direction

func _on_summoning_animation_finished():
	if running_direction.x < 0:
		monster_animation.flip_h = true
	charge_up()

func charge_up():
	monster_animation.play("charging_up")
	#charging_up_audio.play()

func _on_charging_up_animation_finished():
	monster_animation.play("idle")
	is_running = true

func _on_animated_sprite_2d_animation_finished():
	if monster_animation.animation == "charging_up":
		_on_charging_up_animation_finished()
	super()

func _physics_process(delta):
	super(delta)
	if is_running:
		var velocity = running_direction * _speed * delta
		position += velocity
