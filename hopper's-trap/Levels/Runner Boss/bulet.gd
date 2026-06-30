extends CharacterBody2D

var speed = 200
var plr_pos : Vector2

func _ready() -> void:
	print(plr_pos)
	var direction = (plr_pos - global_position).normalized()
	print(direction)
	velocity = direction * speed
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
