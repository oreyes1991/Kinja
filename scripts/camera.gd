extends Camera2D
@export var player: CharacterBody2D
@export_range(0, 1) var weight: float

func _process(delta):
	if is_instance_valid(player):
		global_position = lerp(global_position, player.global_position, weight)
	else:
		global_position = lerp(global_position, Vector2(0,0), weight)
