class_name rat_enemy
extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var edge_detector: RayCast2D = $RayCast2D

@export var direction: int = -1 
@export var speed: float = 60.0

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("walk")

func _physics_process(delta):
	if direction == 1:
		edge_detector.target_position.x *= -1 
		animated_sprite_2d.flip_h = true
	if direction == -1:
		edge_detector.target_position.x *= -1
		animated_sprite_2d.flip_h = false
	if not edge_detector.is_colliding():
		direction = direction * -1
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * speed
	move_and_slide()

# this is the kill collider
func _on_area_2d_area_entered(area):
	print(area.name)
	if (area.name == "kill_area"):
		queue_free()
	if (area.name == "foot_collider"):
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		print("me electrocutaste pedrito!!!")
		queue_free()
