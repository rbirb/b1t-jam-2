extends Camera2D

func _ready() -> void:
	Global.enable_main_camera.connect(func(): enabled = false)
	Global.disable_main_camera.connect(func(): enabled = true)
