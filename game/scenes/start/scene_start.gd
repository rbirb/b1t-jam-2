extends Node2D

var space_slide := false
var fullscreen_slide := false

func _ready() -> void:
	$Lines.visible = true
	$Start.visible = true
	$Lines2.visible = false
	$Space.visible = false
	$Lines3.visible = false
	$Fullscreen.visible = false

func end_scene():
	Global.finished_scene.emit()
	await get_tree().create_timer(2).timeout
	Global.change_scene.emit()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game") and not space_slide:
		space_slide = true
		$Lines.visible = false
		$Start.visible = false
		$Lines2.visible = true
		$Space.visible = true
	elif Input.is_action_just_pressed("text_continue") and space_slide and not fullscreen_slide:
		$Lines2.visible = false
		$Space.visible = false
		$Lines3.visible = true
		$Fullscreen.visible = true
		fullscreen_slide = true
	elif Input.is_action_just_pressed("fullscreen") and space_slide and fullscreen_slide:
		end_scene()
