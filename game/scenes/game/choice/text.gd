extends Label

@onready var window := get_window()
var offset: Vector2 = position:
	set(v):
		offset = v
		position = offset
		pivot_offset = -offset

func _ready() -> void:
	Global.window_resized.connect(update_size)
	update_size()

func update_size():
	scale = Vector2(clamp((window.size.x / Global.size.x) - 5, 1, 8), clamp((window.size.x / Global.size.x) - 5, 1, 8))
	offset = position
