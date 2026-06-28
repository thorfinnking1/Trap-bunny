extends Node2D

@onready var bearani: AnimationPlayer = $bearani
@onready var bunbun: CharacterBody2D = $bunbun
@onready var bear: Node2D = $bear

var sleeping=0

func _process(delta: float) -> void:
	if sleeping==2:
		bear.global_position.x=lerp(bear.global_position.x,bunbun.global_position.x,delta)
		if (bear.global_position.x-bunbun.global_position.x)<0:
			bear.scale.x=-2
		else:
			bear.scale.x=2

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr") and sleeping==0:
		bearani.play("waking up")
		sleeping=1
		await bearani.animation_finished
		bearani.play("walkingaround")
		sleeping=2
