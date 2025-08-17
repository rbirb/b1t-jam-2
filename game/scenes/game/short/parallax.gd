extends Parallax2D

@onready var window := get_window()
var tw_move: Tween
var target_offset: float = 0.0

func _ready() -> void:
	Global.window_resized.connect(update_size)
	update_size()
	Global.game_sf_move_right.connect(move_right)

func move_right():
	if tw_move != null:
		tw_move.kill()
	scroll_offset.x = target_offset
	target_offset += Global.game_sf_move_distance * return_scale()
	tw_move = create_tween()
	tw_move.tween_property(self, "scroll_offset:x", target_offset, Global.game_sf_move_duration).from_current().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func return_scale() -> float:
	return clamp((window.size.x / Global.size.x), 1, 11)

func update_size():
	repeat_size.x = return_scale() * 208
