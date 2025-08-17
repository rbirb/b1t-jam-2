extends CoolSprite

var active := false:
	set(v):
		if v:
			self.offset.x = 55
		active = v
const MARGIN := 10

func _process(delta: float) -> void:
	if not active:
		return
	
	var mouse_pos := get_global_mouse_position()
	if mouse_pos.x > MARGIN:
		self.offset.x = lerp(self.offset.x, 45, 0.1)
	elif mouse_pos.x < -MARGIN:
		self.offset.x = lerp(self.offset.x, 65, 0.1)
	else:
		self.offset.x = lerp(self.offset.x, 55, 0.1)
