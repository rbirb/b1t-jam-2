extends Node2D

var current_scene_name: String
var current_scene_i
const SCENE_CHRONOLOGY: Array[Dictionary] = [
	{"s":preload("res://game/scenes/start/scene_start.tscn"), "wc":Color("c79187"), "bc":Color("050d1b"), "n":"start"},
	{"s":preload("res://game/scenes/scenes1/scenes1.tscn"), "wc":Color("f0ddb8"), "bc":Color("171029"), "n":"s1"},
	{"s":preload("res://game/scenes/game/scene_game.tscn"), "wc":Color("ede4c3ff"), "bc":Color("37462c"), "n":"game"},
	{"s":preload("res://game/scenes/scenes2/scenes_2.tscn"), "wc":Color("f0ddb8"), "bc":Color("171029"), "n":"s2"},
	{"s":preload("res://game/scenes/end/end.tscn"), "wc":Color("c79187"), "bc":Color("050d1b"), "n":"end"},
]
var scene_index := 0

func _ready() -> void:
	if Global.svc == null:
		await Global.svc_filled
	Global.change_gscene.connect(on_change_gscene)
	next_scene()

func on_change_gscene():
	next_scene()

func next_scene():
	if scene_index >= SCENE_CHRONOLOGY.size(): return
	var s = SCENE_CHRONOLOGY[scene_index]
	current_scene_name = s["n"]
	Global.set_pallette(s["wc"], s["bc"])
	load_scene(s["s"])
	scene_index += 1

func load_scene(s: PackedScene):
	remove_scene()
	current_scene_i = s.instantiate()
	add_child(current_scene_i)

func remove_scene():
	if current_scene_i != null:
		remove_child(current_scene_i)
		current_scene_i.queue_free()
