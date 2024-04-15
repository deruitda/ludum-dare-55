extends Node

signal attack
signal attack_finished
signal area_entered(area)

@export var attack_time_in_seconds: float = 0.25
@export var attack_radius: float = 1.0
@export var cooldown_in_seconds: float = 4.0

@onready var attack_timer = $AttackTimer
@onready var attack_area = $AttackArea
@onready var attack_cooldown_timer = $AttackCooldownTimer

@onready var currently_attacking: bool = false
@onready var can_attack: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currently_attacking == false and can_attack == true:
		currently_attacking = true
		make_attack()
	pass

func start_attacking():
	can_attack = true

func make_attack():
	#attack_area.visible = true
	attack_timer.start(attack_time_in_seconds)
	attack.emit()
	
func revoke_attack():
	attack_finished.emit()
	attack_cooldown_timer.start(cooldown_in_seconds)


func _on_attack_timer_timeout():
	attack_timer.stop()
	revoke_attack()

func _on_attack_cooldown_timer_timeout():
	attack_cooldown_timer.stop()
	make_attack()


func _on_attack_area_area_entered(area):
	area_entered.emit(area)
