extends RichTextLabel
signal continue_pressed

const speed = 0.06

func _ready() -> void:
	visible_characters = 0

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("text_continue") and visible_characters != 0:
		continue_pressed.emit()

func activate():
	visible_characters = 0
	var duration = text.length() * speed
	var tween := create_tween()
	tween.tween_property(self, "visible_characters", text.length(), duration)
	await continue_pressed
	if tween.is_running():
		tween.stop()
		visible_characters = text.length()
		await continue_pressed
	Global.finished_text.emit()
