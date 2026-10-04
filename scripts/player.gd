extends CharacterBody2D

@export var SPEED:= 200.0
@export var JUMP_VELOCITY:= -320.0
@export var health:= 3
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var has_take_damage := false
@onready var player_area = $player_area
@onready var damage_timer = $damage_timer

signal health_changed
signal player_death

func  _ready():
	animated_sprite_2d.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle damage animation
	if (has_take_damage):
		modulate_damage_animation(randf_range(0.0, 1.0))
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("running")
	if direction == 1:
		animated_sprite_2d.play("running")
		animated_sprite_2d.flip_h = false
	if direction == 0:
		animated_sprite_2d.play("idle")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func modulate_damage_animation(alpha: float):
	var modulation = lerp(animated_sprite_2d.self_modulate, Color(animated_sprite_2d.self_modulate, alpha), 0.5)
	animated_sprite_2d.self_modulate = modulation

func take_damage():
	if (has_take_damage):
		return
	damage_timer.start()
	health -= 1
	has_take_damage = true
	if (health == 0):
		player_death.emit()
		queue_free()
	health_changed.emit(health)

func _on_foot_collider_area_entered(area):
	if area.name == "kill_collider":
		velocity.y = JUMP_VELOCITY / 2
	if area.name == 'kill_area':
		player_death.emit()
		queue_free()


func _on_player_area_area_entered(area):
	if area.name == "damage_collider":
		take_damage()

func _on_damage_timer_timeout():
	modulate_damage_animation(1)
	has_take_damage = false
