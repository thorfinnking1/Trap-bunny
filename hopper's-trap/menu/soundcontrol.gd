extends Node2D

@export var sound : AudioStreamPlayer

func _process(_delta: float) -> void:
	sound.volume_db = Gl.sounddb
	if Gl.sounddb <=-40:
		sound.stream_paused = true
	else:
		sound.stream_paused = false
