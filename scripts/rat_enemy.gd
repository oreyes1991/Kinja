class_name rat_enemy
extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var edge_detector: RayCast2D = $RayCast2D

@export var direction: int = 1 
@export var speed: float = 60.0

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("walk")

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()

# this is the kill collider
func _on_area_2d_area_entered(area):
	if (area.name == "foot_collider"):
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		print("me electrocutaste pedrito!!!")
		queue_free()
