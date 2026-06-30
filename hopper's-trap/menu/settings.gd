extends Control

func _ready() -> void:
	$HSlider.value = Gl.sounddb
func _process(_delta: float) -> void:
	Gl.sounddb = $HSlider.value


func _on_button_pressed() -> void:
	Scenemanager.leave("res://menu/main menu.tscn","fade")
