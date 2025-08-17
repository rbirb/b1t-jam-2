class_name CoolSprite extends Node2D

@export var enable_shader := true
@onready var window := get_window()
var shader_tween: Tween

func _ready() -> void:
	cool_sprite_ready()

func cool_sprite_ready():
	if position != Vector2.ZERO:
		push_warning(name+" is not positioned at 0, 0")
	if enable_shader:
		material = ShaderMaterial.new()
		material.shader = preload("res://shaders/dissolve_trans.gdshader")
	Global.finished_gscene.connect(dissolve)
	Global.sprites_appear.connect(appear)
	Global.sprites_disappear.connect(dissolve)
	Global.window_resized.connect(update_size)
	update_size()
	if enable_shader:
		material.set_shader_parameter("progress", 1.0)
		appear()

func update_size():
	scale = Vector2(clamp((window.size.x / Global.size.x), 1, 11), clamp((window.size.x / Global.size.y), 1, 11))

func appear():
	if not enable_shader: return
	if shader_tween != null:
		if shader_tween.is_running():
			shader_tween.stop()
	material.set_shader_parameter("progress", 1.0)
	shader_tween = create_tween()
	shader_tween.tween_property(self, "material:shader_parameter/progress", 0.0, 1).from_current()

func dissolve():
	if not enable_shader: return
	if shader_tween != null:
		if shader_tween.is_running():
			shader_tween.stop()
	material.set_shader_parameter("progress", 0.0)
	shader_tween = create_tween()
	shader_tween.tween_property(self, "material:shader_parameter/progress", 1.0, 1).from_current()
