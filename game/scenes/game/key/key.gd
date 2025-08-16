extends CoolSprite

var key: int
var order := 0
var pressed := false

func get_random_key() -> int:
	return Global.KEYBOARD_KEYS.keys()[randi_range(0, Global.KEYBOARD_KEYS.keys().size() - 1)]

func set_offset(pos: Vector2):
	pos /= self.scale
	self.offset = pos
	$Label.position = Vector2(pos.x - 2, pos.y - 10)
	$Label.pivot_offset = -$Label.position

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(key) and not pressed:
		if order == 0:
			press()
		elif order > 0:
			order -= 1

func press():
	pressed = true
	Global.key_pressed.emit()
	self.texture = preload("res://game/scenes/game/key/key_pressed.png")
	$Label.position.y += 1
	$Timer.start()
	await $Timer.timeout
	queue_free()

func _ready() -> void:
	cool_sprite_ready()
	$Label.text = Global.KEYBOARD_KEYS[key]
