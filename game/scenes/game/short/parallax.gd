extends Parallax2D

@onready var window := get_window()
@export var move_duration := 0.2
@export var move_distance := 50.0
var tw_move: Tween
var target_offset: float = 0.0

func _ready() -> void:
	Global.window_resized.connect(update_size)
	update_size()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start_game"):
		move_left()

func move_left():
	if tw_move != null:
		tw_move.kill()
	scroll_offset.x = target_offset
	target_offset += move_distance * return_scale()
	tw_move = create_tween()
	tw_move.tween_property(self, "scroll_offset:x", target_offset, move_duration).from_current().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func return_scale() -> float:
	return clamp((window.size.x / Global.size.x), 1, 11)

func update_size():
	repeat_size.x = return_scale() * 208
