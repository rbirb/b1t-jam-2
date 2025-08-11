extends Node

var current_song: AudioStreamPlayer = null
var current_amb: AudioStreamPlayer = null
const SOUND_PATH := "res://sounds/"

func _process(delta: float) -> void:
	if current_song != null:
		if !current_song.playing:
			current_song.play()
	if current_amb != null:
		if !current_amb.playing:
			current_amb.play()

func play_amb(amb: String, volume_db:=0.0, fade_dur:=1.0):
	await stop_current_amb()
	current_amb = AudioStreamPlayer.new()
	add_child(current_amb)
	current_amb.stream = load(SOUND_PATH+amb)
	current_amb.bus = "Sounds"
	current_amb.volume_db = -62.0
	fade_volume(current_amb, volume_db, fade_dur)
	current_amb.play()

func stop_current_amb(fade_dur:=1.0):
	if current_amb == null: return
	await fade_volume(current_amb, -62.0, fade_dur)
	current_amb.stop()
	current_amb = null

func play_song(song: String, volume_db:=0.0, fade:=false, fade_dur:=1.0):
	await stop_current_song(fade, fade_dur)
	current_song = AudioStreamPlayer.new()
	add_child(current_song)
	current_song.stream = load(SOUND_PATH+song)
	current_song.bus = "Music"
	if fade:
		current_song.volume_db = -62.0
		fade_volume(current_song, volume_db, fade_dur)
	else:
		current_song.volume_db = volume_db
	current_song.play()

func stop_current_song(fade:=true, fade_dur:=1.0):
	if current_song == null: return
	if fade:
		await fade_volume(current_song, -62.0, fade_dur)
	current_song.stop()
	current_song = null

func fade_volume(player: AudioStreamPlayer, to_volume: float, duration: float):
	var tween = create_tween()
	
	if player.volume_db > to_volume:
		tween.tween_property(player, "volume_db", to_volume, duration).from_current().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	else:
		tween.tween_property(player, "volume_db", to_volume, duration).from_current().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	await tween.finished

func play_sound(sound: String, volume_db:=0.0, pitch_scale:=1.0, max_polyphony:=1, bus:="Sounds"):
	var soundinstance := AudioStreamPlayer.new()
	add_child(soundinstance)
	soundinstance.stream = load(SOUND_PATH+sound)
	soundinstance.bus = bus
	soundinstance.volume_db = volume_db
	soundinstance.pitch_scale = pitch_scale
	soundinstance.max_polyphony = max_polyphony
	
	soundinstance.play()
	await soundinstance.finished
	soundinstance.queue_free()
