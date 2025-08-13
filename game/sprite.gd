class_name CoolSprite extends Node2D

@export var size := Vector2(208, 208)
@onready var window := get_window()
var shader_tween: Tween

func _ready() -> void:
	material = ShaderMaterial.new()
	material.shader = preload("res://shaders/dissolve_trans.gdshader")
	material.set_shader_parameter("progress", 1.0)
	Global.finished_scene.connect(dissolve)
	Global.window_resized.connect(update_size)
	update_size()
	appear()

func update_size():
	scale = Vector2(clamp((window.size.x / size.x), 1, 11), clamp((window.size.x / size.y), 1, 11))

func appear():
	if shader_tween != null:
		if shader_tween.is_running():
			shader_tween.stop()
	shader_tween = create_tween()
	shader_tween.tween_property(self, "material:shader_parameter/progress", 0.0, 1).from_current()

func dissolve():
	if shader_tween != null:
		if shader_tween.is_running():
			shader_tween.stop()
	shader_tween = create_tween()
	shader_tween.tween_property(self, "material:shader_parameter/progress", 1.0, 1).from_current()
