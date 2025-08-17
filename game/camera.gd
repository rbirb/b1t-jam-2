extends Camera2D

@onready var orig_pos := position

func _process(delta: float) -> void:
	var pos := get_global_mouse_position()
	position = lerp(position, (orig_pos.direction_to(pos) * 10), 0.1)
