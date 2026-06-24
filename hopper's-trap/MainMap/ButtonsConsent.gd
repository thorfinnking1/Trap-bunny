extends Control


func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file(Gl.Scene)
	Plr.inLevel = true
	queue_free()


func _on_no_pressed() -> void:
	queue_free()
