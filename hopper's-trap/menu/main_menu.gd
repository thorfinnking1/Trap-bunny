extends Control



func _on_play_pressed() -> void:
	Gl.InLvl = true
	Scenemanager.leave("res://MainMap/map.tscn","fade")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_setings_pressed() -> void:
	Scenemanager.leave("res://menu/settings.tscn","fade")

func _on_credits_pressed() -> void:
	Scenemanager.leave("res://menu/credits.tscn","fade")
