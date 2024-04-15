extends Control


@onready var hades_animation = %HadesAnimation

func _ready():
	SummoningSignal.connect("incantation_typing_updated", _on_incantation_typing_updated)


func _on_incantation_typing_updated():
	print("incantation typing updated to ", SummoningState.is_incantation_typing)
	if SummoningState.is_incantation_typing:
		if hades_animation.animation != "speaking":
			hades_animation.play("speaking")
	else:
		if hades_animation.animation != "idle":
			hades_animation.play("idle")


