extends Node2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_2d.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loop_song()

func loop_song():
	await  audio_stream_player_2d.finished
	audio_stream_player_2d.play()
