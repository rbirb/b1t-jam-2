extends Node2D

@export var chronology :Array[Dictionary] = [
	{"s":null,"t":null},
]

func _ready() -> void:
	Audio.play_song("music/flourishflower.wav")
	for s in chronology:
		get_node(s["s"]).visible = true
		if chronology.find(s) == 0:
			await get_tree().create_timer(1).timeout
		get_node(s["t"]).activate()
		await Global.finished_text
		get_node(s["t"]).reset()
		if chronology.find(s) != 2:
			get_node(s["s"]).visible = false
	Global.finished_gscene.emit()
	await get_tree().create_timer(1).timeout
	Audio.stop_current_song()
	Global.change_gscene.emit()
