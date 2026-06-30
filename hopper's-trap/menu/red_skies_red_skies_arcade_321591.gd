extends AudioStreamPlayer2D

func _process(_delta: float) -> void:
	if !Gl.InLvl:
		volume_db = Gl.sounddb
		if volume_db <= -40:
			stream_paused = true
		elif volume_db >= -39:
			stream_paused = false
	else :
		stop()
