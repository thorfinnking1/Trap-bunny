extends Control


func _on_back_pressed() -> void:
	Scenemanager.leave("res://menu/main menu.tscn","fade")
