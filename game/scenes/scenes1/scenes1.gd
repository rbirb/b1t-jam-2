extends Node2D

@export var chronology :Array[Dictionary] = [
	{"s":null,"t":null},
]

func _ready() -> void:
	for s in chronology:
		get_node(s["s"]).visible = true
		get_node(s["t"]).activate()
		await Global.finished_text
		get_node(s["t"]).reset()
		get_node(s["s"]).visible = false
