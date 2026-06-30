extends CharacterBody2D

var speed = 200
var plr_pos : Vector2

func _ready() -> void:
	print(plr_pos)
	var direction = (global_position-plr_pos).normalized()
	print(direction)
	velocity =direction * speed
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
