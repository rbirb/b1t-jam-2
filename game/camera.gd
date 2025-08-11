extends Camera2D

@onready var orig_pos := global_position

func _process(delta: float) -> void:
	var pos := get_global_mouse_position()
	global_position = lerp(global_position, orig_pos.direction_to(pos) * 4, 0.1)
