extends Node2D

@export var chronology :Array[Dictionary] = [
	{"s":null,"t":null, "wc": null, "bc": null},
]

func _ready() -> void:
	for s in chronology:
		Global.set_pallette(s["wc"], s["bc"])
		get_node(s["s"]).visible = true
		get_node(s["t"]).activate()
		await Global.finished_text
		get_node(s["t"]).reset()
		get_node(s["t"]).active = true
		get_node(s["s"]).visible = false
