extends CanvasLayer

@onready var ani: AnimationPlayer = $AnimationPlayer
#function
func leave(place:String,aniName:String)->void:
	ani.play(aniName)#play animation backwards so it apears not fade
	await ani.animation_finished
	get_tree().change_scene_to_file(place)
	ani.play_backwards(aniName)
