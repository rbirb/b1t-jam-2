extends MoveSprite

const TEXTURES: Array[Texture2D] = [preload("res://game/scenes/game/short/flower/flower1.png"), preload("res://game/scenes/game/short/flower/flower2.png")]

func _ready() -> void:
	move_sprite_ready()
	self.texture = TEXTURES[randi_range(0, TEXTURES.size() - 1)]
