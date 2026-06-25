extends Node2D

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var pointer: Sprite2D = $DiedScreen/DiedScreen2

var value:=20.0 #should start at 0 and end at 46

func _process(_delta: float) -> void:
	progress_bar.value=lerp(progress_bar.value,value,0.1)
	pointer.position.x=progress_bar.value #move_toward(pointer.global_position.x,value,-1)

func _on_button_2_pressed() -> void:
	Scenemanager.leave("res://MainMap/map.tscn","fade")

func _on_button_pressed() -> void:
	Scenemanager.leave(get_tree().current_scene.scene_file_path,"fade")
