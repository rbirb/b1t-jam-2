class_name MoveSprite extends CoolSprite

@export var move_distance := 22.0
@export var move_duration := 0.2
var tw_move: Tween

var sprite_pos: Vector2 = self.offset:
	set(v):
		sprite_pos = v
		set_offset(sprite_pos)
var target_pos: Vector2 = sprite_pos

func _ready() -> void:
	move_sprite_ready()

func move_sprite_ready():
	cool_sprite_ready()
	Global.game_tf_move_down.connect(move_down)
	Global.game_sf_move_left.connect(move_left)

func move_down():
	if tw_move != null:
		tw_move.kill()
	sprite_pos = target_pos
	target_pos.y += move_distance * scale.y
	tw_move = create_tween()
	tw_move.tween_property(self, "sprite_pos", target_pos, move_duration).from_current().set_trans(Tween.TRANS_SINE)#.set_ease(Tween.EASE_IN)

func move_left():
	if tw_move != null:
		tw_move.kill()
	sprite_pos = target_pos
	target_pos.x -= move_distance * scale.x
	tw_move = create_tween()
	tw_move.tween_property(self, "sprite_pos", target_pos, move_duration).from_current().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func set_offset(pos: Vector2):
	self.offset = pos
	if self.offset.y > get_viewport().size.y + 100:
		queue_free()
