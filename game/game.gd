extends Node2D

var current_scene_name: String
var current_scene_i
const SCENE_CHRONOLOGY: Array[Dictionary] = [
	{"s":preload("res://game/scenes/start/start.tscn"), "wc":Color("c79187"), "bc":Color("050d1b"), "n":"start"},
	{"s":preload("res://game/scenes/scene1/scene1.tscn"), "wc":Color("f0ddb8"), "bc":Color("171029"), "n":"s1"},
]
var scene_index := 0

func _ready() -> void:
	Global.bg = $BG/BG
	if Global.svc == null:
		await Global.svc_filled
	Global.change_scene.connect(on_change_scene)
	next_scene()

func on_change_scene():
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
