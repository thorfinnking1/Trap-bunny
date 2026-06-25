extends Node2D

@onready var ground: Node2D = $going

const BEARTRAP = preload("uid://b4qbbdekef3q3")
var speed=150

func _process(delta: float) -> void:
	for kids in ground.get_children():
		kids.global_position.x-=speed*delta

func _on_timer_timeout() -> void:
	for i in range(randi_range(1,2)):
		var trap=BEARTRAP.instantiate()
		ground.add_child(trap)
		trap.time=5
		trap.global_position=Vector2(ground.global_position.x,randf_range(240,320))
