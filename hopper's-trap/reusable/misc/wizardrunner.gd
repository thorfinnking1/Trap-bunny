extends Node2D

var pos=0

@onready var animation: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		animation.play(str(pos))
		pos+=1
		if pos==4:
			pos=0
