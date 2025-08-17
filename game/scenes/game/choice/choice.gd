extends Node2D

@onready var invert_orig_offset : float = $InvertColors.offset.x
const MARGIN := 10
var active := false
var not_hovered_any := true
var hovered_left := false
var hovered_right := false

func _process(delta: float) -> void:
	if not active:
		return
	
	var mouse_pos := get_global_mouse_position()
	if mouse_pos.x > MARGIN:
		if not hovered_right:
			hovered_left = false
			hovered_right = true
			not_hovered_any = false
			hover_spread()
			unhover_grow()
	elif mouse_pos.x < -MARGIN:
		if not hovered_left:
			hovered_left = true
			hovered_right = false
			not_hovered_any = false
			hover_grow()
			unhover_spread()
	else:
		if not not_hovered_any:
			hovered_left = false
			hovered_right = false
			not_hovered_any = true
			unhover_grow()
			unhover_spread()

func _ready() -> void:
	$ChoiceText.visible = false
	$InvertColors.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("choose"):
		if hovered_left:
			choose_grow()
		elif hovered_right:
			choose_spread()

func choose_grow():
	disappear()

func choose_spread():
	deactivate()
	dissapear_anim()
	Global.finished_gscene.emit()
	await get_tree().create_timer(1).timeout
	Global.change_gscene.emit()

func hover_grow():
	$ChoiceText/Grow.add_theme_constant_override("shadow_outline_size", 8)

func unhover_grow():
	$ChoiceText/Grow.add_theme_constant_override("shadow_outline_size", 0)

func hover_spread():
	$ChoiceText/Spread.add_theme_constant_override("shadow_outline_size", 8)

func unhover_spread():
	$ChoiceText/Spread.add_theme_constant_override("shadow_outline_size", 0)

func appear():
	$ChoiceText/Grow.offset = Vector2(-73, -12)
	$ChoiceText/Spread.offset = Vector2(32, -12)
	$InvertColors.offset.x = invert_orig_offset
	visible = true
	Global.sprites_appear.emit()
	await get_tree().create_timer(1).timeout
	$TextLayer/Text.activate()
	await Global.finished_text
	$TextLayer/Text.reset()
	$TextLayer/Text.active = true
	active = true
	$InvertColors.active = true
	$ChoiceText.visible = true
	$InvertColors.visible = true

func deactivate():
	active = false
	hovered_left = false
	hovered_right = false
	not_hovered_any = true
	unhover_grow()
	unhover_spread()
	$InvertColors.active = false

func dissapear_anim():
	var tw_grow_move := create_tween()
	tw_grow_move.tween_property($ChoiceText/Grow, "offset:x", -get_viewport().size.x/1.5, 0.6).set_trans(Tween.TRANS_SINE)
	var tw_spread_move := create_tween()
	tw_spread_move.tween_property($ChoiceText/Spread, "offset:x", get_viewport().size.x/1.5, 0.6).set_trans(Tween.TRANS_SINE)
	var tw_invert_move := create_tween()
	tw_invert_move.tween_property($InvertColors, "offset:x", 212, 0.7).set_trans(Tween.TRANS_SINE)
	await tw_invert_move.finished

func disappear():
	deactivate()
	dissapear_anim()
	Global.sprites_disappear.emit()
	await get_tree().create_timer(1).timeout
	visible = false
	$ChoiceText.visible = false
	$InvertColors.visible = false
	Global.choice_hidden.emit()
