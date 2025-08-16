extends Node2D

@export var stage := 1
const STEMS: Dictionary[int, Array] = {
	1: [preload("res://game/scenes/game/tall/stage1/stem/stem1.png"), preload("res://game/scenes/game/tall/stage1/stem/stem2.png")],
}

func _ready() -> void:
	Global.game_tf_move_down.connect(extend)

func extend():
	shift_texture()

func shift_texture():
	$"3".texture = $"2".texture
	$"2".texture = $"1".texture
	$"1".texture = STEMS[stage][randi_range(0, STEMS[stage].size() - 1)]
