class_name MoveSprite extends CoolSprite

@export var move_distance := 22.0
@export var move_duration := 0.2
@export var tf := true
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
	if tf:
		Global.game_tf_move_down.connect(move_down)
	else:
		Global.game_sf_move_right.connect(move_right)

func move_down():
	if not Global.game_is_tf_current or Global.game_choice: return
	if tw_move != null:
		tw_move.kill()
	sprite_pos = target_pos
	target_pos.y += move_distance
	tw_move = create_tween()
	tw_move.tween_property(self, "sprite_pos:y", target_pos.y, move_duration).from_current().set_trans(Tween.TRANS_SINE)#.set_ease(Tween.EASE_IN)

func move_right():
	if Global.game_is_tf_current or Global.game_choice: return
	if tw_move != null:
		tw_move.kill()
	sprite_pos = self.offset
	target_pos = self.offset
	target_pos.x += Global.game_sf_move_distance
	tw_move = create_tween()
	tw_move.tween_property(self, "sprite_pos", target_pos, Global.game_sf_move_duration).from_current().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func set_offset(pos: Vector2):
	self.offset = pos
	if (self.offset.y > get_viewport().size.y / self.scale.y + 1000)\
		or (self.offset.x > get_viewport().size.x / self.scale.x):
		queue_free()
