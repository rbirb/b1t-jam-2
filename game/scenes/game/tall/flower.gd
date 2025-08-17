extends CoolSprite

const TEXTURES: Dictionary[int, Texture2D] = {
	1: preload("res://game/scenes/game/tall/stage1/flower1.png"),
	2: preload("res://game/scenes/game/tall/stage2/flower2.png"),
	3: preload("res://game/scenes/game/tall/stage3/flower3.png"),
	4: preload("res://game/scenes/game/tall/stage4/flower4.png"),
}

func _ready() -> void:
	cool_sprite_ready()
	Global.game_tf_stage_updated.connect(update_texture)

func update_texture():
	self.texture = TEXTURES[Global.game_tf_stage]
