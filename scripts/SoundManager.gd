extends Node

# Dictionary to hold your sounds for easy access
var sounds = {
	"click": preload("res://assets/Sound effects/UI/synth_confirmation.wav"),
	"hit": preload("res://assets/Sound effects/Combat and Gore/slap.wav"),
	"miss": preload("res://assets/Sound effects/Combat and Gore/swipe.wav"),
	"hurt": preload("res://assets/Sound effects/Combat and Gore/punch.wav"),
	"level_up": preload("res://assets/Sound effects/UI/pop_1.wav")
}

@onready var sfx_pool_size = 8
var sfx_players: Array[AudioStreamPlayer] = []
var music_player: AudioStreamPlayer

func _ready():
	# Create a pool of SFX players so multiple sounds can play at once
	for i in range(sfx_pool_size):
		var p = AudioStreamPlayer.new()
		add_child(p)
		p.bus = "SFX"
		sfx_players.append(p)
	
	# Create a dedicated music player
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = "Music"

func play_sfx(sound_name: String):
	if sounds.has(sound_name):
		# Find a player that isn't currently playing
		for p in sfx_players:
			if not p.playing:
				p.stream = sounds[sound_name]
				p.play()
				return
	else:
		print("Sound not found: ", sound_name)

func play_music(music_stream: AudioStream):
	if music_player.stream == music_stream:
		return # Don't restart if it's already playing
	music_player.stream = music_stream
	music_player.play()
