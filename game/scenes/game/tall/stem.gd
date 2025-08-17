extends Node2D

const STEMS: Dictionary[int, Array] = {
	1: [preload("res://game/scenes/game/tall/stage1/stem/stem1.png"), preload("res://game/scenes/game/tall/stage1/stem/stem2.png")],
	2: [preload("res://game/scenes/game/tall/stage2/stem/1.png"), preload("res://game/scenes/game/tall/stage2/stem/2.png")],
	3: [preload("res://game/scenes/game/tall/stage3/stem/1.png"), preload("res://game/scenes/game/tall/stage3/stem/2.png")],
	4: [preload("res://game/scenes/game/tall/stage4/stem/1.png"), preload("res://game/scenes/game/tall/stage4/stem/2.png")],
}

func _ready() -> void:
	Global.game_tf_move_down.connect(extend)
	Global.game_tf_stage_updated.connect(update_textures)

func extend():
	shift_texture()

func update_textures():
	$"3".texture = get_random_texture()
	$"2".texture = get_random_texture()
	$"1".texture = get_random_texture()

func shift_texture():
	$"3".texture = $"2".texture
	$"2".texture = $"1".texture
	$"1".texture = get_random_texture()

func get_random_texture() -> Texture2D:
	return STEMS[Global.game_tf_stage][randi_range(0, STEMS[Global.game_tf_stage].size() - 1)]
