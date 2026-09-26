class_name rat_enemy
extends RigidBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("walk")
	pass # Replace with function body.
# this is the kill collider
func _on_area_2d_area_entered(area):
	if (area.name == "foot_collider"):
		print("me electrocutaste pedrito!!!")
		queue_free()
