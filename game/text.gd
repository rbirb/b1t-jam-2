extends RichTextLabel
signal continue_pressed

const speed = 0.07
var active := true
@onready var window := get_window()
@export var _size := 112

func _ready() -> void:
	visible_characters = 0
	#material = ShaderMaterial.new()
	#material.shader = preload("res://shaders/dissolve_trans.gdshader")
	#material.set_shader_parameter("progress", 0.0)
	#Global.finished_gscene.connect(dissolve)
	Global.window_resized.connect(update_size)
	update_size()

func update_size():
	scale = Vector2(clamp((window.size.x / _size) - 5, 1, 8), clamp((window.size.x / _size) - 5, 1, 8))
	pivot_offset = -position

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("text_continue") and visible_characters != 0 and $Timer.is_stopped():
		$Timer.start()
		continue_pressed.emit()

func reset():
	visible_characters = 0

#func dissolve():
	#var shader_tween := create_tween()
	#shader_tween.tween_property(self, "material:shader_parameter/progress", 1.0, 1).from_current()

func activate():
	if not active: return
	visible_characters = 0
	var duration = text.length() * speed
	var tween := create_tween()
	tween.tween_property(self, "visible_characters", text.length(), duration)
	await continue_pressed
	if tween.is_running():
		tween.stop()
		visible_characters = text.length()
		await continue_pressed
	active = false
	Global.finished_text.emit()
