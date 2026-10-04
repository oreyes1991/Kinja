extends PanelContainer

@onready var healt_1 = $HBoxContainer/healt_1
@onready var health_2 = $HBoxContainer/health_2
@onready var health_3 = $HBoxContainer/health_3
@onready var game_over_label = $GameOverContainer/GameOverLabel
@onready var health = $"."

func _ready():
	game_over_label.hide()
	dark_background(0)

func _on_player_health_changed(amount):
	if amount == 2:
		health_3.hide()
	if amount == 1:
		health_2.hide()
	if amount == 0:
		healt_1.hide()

func dark_background(value: int):
	var style:StyleBoxFlat = StyleBoxFlat.new()
	if (value == 1):
		style.bg_color =  Color.BLACK
		style.bg_color.a = 0.8
	else: 
		style.bg_color =  Color.BLACK
		style.bg_color.a = 0
	health.add_theme_stylebox_override("panel", style)

func _on_player_death():
	healt_1.hide()
	health_2.hide()
	health_3.hide()
	game_over_label.show()
	dark_background(1)
