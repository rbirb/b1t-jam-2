extends Node2D

@onready var lx1 := $TallFlower/LKeyArea/X1
@onready var lx2 := $TallFlower/LKeyArea/X2
@onready var ly1 := $TallFlower/LKeyArea/Y1
@onready var ly2 := $TallFlower/LKeyArea/Y2
@onready var rx1 := $TallFlower/RKeyArea/X1
@onready var rx2 := $TallFlower/RKeyArea/X2
@onready var ry1 := $TallFlower/RKeyArea/Y1
@onready var ry2 := $TallFlower/RKeyArea/Y2
@onready var x1 := $ShortFlower/KeyArea/X1
@onready var x2 := $ShortFlower/KeyArea/X2
@onready var y1 := $ShortFlower/KeyArea/Y1
@onready var y2 := $ShortFlower/KeyArea/Y2
const key := preload("res://game/scenes/game/key/key.tscn")
const sf_flower := preload("res://game/scenes/game/short/flower/flower_sf.tscn")
var tf_grow_count := 0
var sf_flower_count := 0
var tf_key_count := 0
var grow_choice_attempt := 0
const TF_STAGE_KEY_AMOUNT: Dictionary[int, Array] = {
	1: [2, 3],
	2: [5, 7],
	3: [8, 12],
	4: [12, 20]
}

func _ready() -> void:
	Global.key_pressed.connect(on_key_pressed)
	Global.choice_grow.connect(hide_choice)
	await get_tree().create_timer(1).timeout
	start_tf_game()

func change_game():
	if Global.game_is_tf_current:
		start_sf_game()
	else:
		start_tf_game()

func start_tf_game():
	Global.game_is_tf_current = true
	if Global.game_tf_stage == 1:
		tf_grow_count = randi_range(10, 15)
	elif Global.game_tf_stage == 2:
		tf_grow_count = randi_range(20, 25)
	elif Global.game_tf_stage == 3:
		tf_grow_count = randi_range(25, 30)
	elif Global.game_tf_stage == 4:
		tf_grow_count = randi_range(30, 50)
	$TallFlower.visible = true
	$ShortFlower.visible = false
	tf_summon_keys()

func start_sf_game():
	Global.game_is_tf_current = false
	sf_flower_count = randi_range(10, 25)
	$TallFlower.visible = false
	$ShortFlower.visible = true
	sf_summon_keys()

func end_tf_game():
	$TallFlower/AnimationShake.play("shake")
	await $TallFlower/AnimationShake.animation_finished
	$TallFlower/FlowerShakeEnd.start()
	await $TallFlower/FlowerShakeEnd.timeout
	show_choice()

func show_choice():
	Global.game_choice = true
	$TallFlower.visible = false
	$Choice.visible = true

func hide_choice():
	Global.game_choice = false
	grow_choice_attempt += 1
	$TallFlower.visible = true
	$Choice.visible = false

func on_key_pressed(k):
	if Global.game_is_tf_current:
		tf_key_pressed(k)
	else:
		sf_key_pressed(k)

func sf_key_pressed(k):
	sf_flower_count -= 1
	if sf_flower_count < 1:
		change_game()
		return
	var flower_i := sf_flower.instantiate()
	flower_i.tf = false
	$ShortFlower.add_child(flower_i)
	flower_i.set_offset(k.offset)
	Global.game_sf_move_right.emit()
	sf_summon_keys()

func tf_key_pressed(k):
	tf_key_count -= 1
	tf_grow_count -= 1
	if tf_grow_count < 1:
		if Global.game_tf_stage < 4:
			Global.game_tf_stage += 1
			change_game()
		else:
			end_tf_game()
		return
	Global.game_tf_move_down.emit()
	if tf_key_count <= 0:
		tf_summon_keys()

func sf_summon_keys():
	Global.game_sf_move_distance = randf_range(10, 25)
	Global.game_sf_move_duration = randf_range(0.2, 0.4)
	var key_i := key.instantiate()
	key_i.tf = false
	key_i.key = key_i.get_random_key()
	$ShortFlower.add_child(key_i)
	key_i.set_offset(sf_get_random_key_pos())

func tf_summon_keys():
	if Global.game_tf_stage < 4:
		tf_key_count = randi_range(TF_STAGE_KEY_AMOUNT[Global.game_tf_stage][0], TF_STAGE_KEY_AMOUNT[Global.game_tf_stage][0])
	else:
		tf_key_count = randi_range(TF_STAGE_KEY_AMOUNT[Global.game_tf_stage][0]+grow_choice_attempt*3, TF_STAGE_KEY_AMOUNT[Global.game_tf_stage][0]+grow_choice_attempt*3)
	var keys: Array[int] = []
	for k in tf_key_count:
		var key_i := key.instantiate()
		key_i.tf = true
		key_i.key = key_i.get_random_key()
		if keys.count(key_i.key) > 0:
			key_i.order = keys.count(key_i.key)
		keys.append(key_i.key)
		$TallFlower.add_child(key_i)
		key_i.set_offset(tf_get_random_key_pos())

func sf_get_random_key_pos() -> Vector2:
	var out_x: int
	var out_y: int
	out_x = randf_range(x1.global_position.x, x2.global_position.x)
	out_y = randf_range(y1.global_position.y, y2.global_position.y)
	return Vector2(out_x, out_y)

func tf_get_random_key_pos() -> Vector2:
	var left := randi_range(0, 1)
	var out_x: int
	var out_y: int
	if left:
		out_x = randf_range(lx1.global_position.x, lx2.global_position.x)
		out_y = randf_range(ly1.global_position.y, ly2.global_position.y)
	else:
		out_x = randf_range(rx1.global_position.x, rx2.global_position.x)
		out_y = randf_range(ry1.global_position.y, ry2.global_position.y)
	return Vector2(out_x, out_y)
