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
var tf_stage := 1
const TF_STAGE_KEY_AMOUNT: Dictionary[int, Array] = {
	1: [2, 3],
	2: [5, 7],
	3: [8, 12],
	4: [12, 20]
}

func _ready() -> void:
	Global.key_pressed.connect(on_key_pressed)
	await get_tree().create_timer(1).timeout
	Global.game_is_tf_current = false
	sf_summon_keys()

func change_game():
	pass

func on_key_pressed(k):
	if Global.game_is_tf_current:
		tf_key_pressed(k)
	else:
		sf_key_pressed(k)

func sf_key_pressed(k):
	sf_flower_count += 1
	var flower_i := sf_flower.instantiate()
	flower_i.tf = false
	$ShortFlower.add_child(flower_i)
	flower_i.set_offset(k.offset)
	Global.game_sf_move_right.emit()
	sf_summon_keys()

func tf_key_pressed(k):
	tf_key_count -= 1
	tf_grow_count += 1
	if tf_grow_count > 250:
		tf_grow_count = 201
	elif tf_grow_count > 200:
		tf_stage = 4
	elif tf_grow_count > 120:
		tf_stage = 3
	elif tf_grow_count > 50:
		tf_stage = 2
	elif tf_grow_count > 20:
		tf_stage = 1
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
	if tf_stage < 4:
		tf_key_count = randi_range(TF_STAGE_KEY_AMOUNT[tf_stage][0], TF_STAGE_KEY_AMOUNT[tf_stage][0])
	else:
		tf_key_count = randi_range(TF_STAGE_KEY_AMOUNT[tf_stage][0]+tf_grow_count-200, TF_STAGE_KEY_AMOUNT[tf_stage][0]+tf_grow_count-200)
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
