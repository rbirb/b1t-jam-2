extends Node2D

func end_scene():
	Global.finished_gscene.emit()
	await get_tree().create_timer(2).timeout
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		end_scene()
