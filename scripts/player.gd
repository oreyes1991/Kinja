extends CharacterBody2D

@export var SPEED:= 200.0
@export var JUMP_VELOCITY:= -320.0
@onready var animated_sprite_2d = $AnimatedSprite2D

func  _ready():
	animated_sprite_2d.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("running")
	if direction == 1:
		animated_sprite_2d.play("running")
		animated_sprite_2d.flip_h = false
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_foot_collider_area_entered(area):
	if area.name == "kill_collider":
		velocity.y = JUMP_VELOCITY / 2
