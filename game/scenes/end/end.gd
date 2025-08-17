extends Node2D

var ended := false

func end_scene():
	if ended: return
	ended = true
	Global.finished_gscene.emit()
	await get_tree().create_timer(2).timeout
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		Audio.play_sound("cl1.wav")
		end_scene()
