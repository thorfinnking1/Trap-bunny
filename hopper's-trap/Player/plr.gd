extends CharacterBody2D

var speed := 35.0
var moving=true
#static var inLevel : float = false
@onready var rabbit_16: Sprite2D = $Rabbit16
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if Gl.player_position:
		global_position=Gl.player_position

func _physics_process(_delta: float) -> void:
	var direction
	#if not inLevel:
	direction = Input.get_vector("Left","Right","Up","Down")
	if direction and moving:
		animation.play("walk")
		if direction.x<0:
			rabbit_16.flip_h=true
		else:
			rabbit_16.flip_h=false
		velocity = direction * speed
	else:
		animation.play("RESET")
		velocity = velocity.move_toward(Vector2.ZERO, speed)
	#elif inLevel:
		#direction = Input.get_axis("Left","Right")
		#if direction != 0:
			#velocity.x = direction * speed
		#else:
			#velocity.x = move_toward(velocity.x,0, speed)
	move_and_slide()
