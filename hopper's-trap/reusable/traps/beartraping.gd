extends Node2D

@onready var animation: AnimationPlayer = $AnimationPlayer

var time:int

signal kill

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		animation.play("catch")
		kill.emit()

func _on_timer_timeout() -> void:
	time-=1
	if time==0:
		queue_free()
