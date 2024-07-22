extends Node2D

@onready var buttons:= [
	$Play,
	$Credits
]

var is_hovered:= false
var game:= preload("res://Scenes/House.tscn")
var cupcakes:= [
	#preload("res://Assets/Exported Art Assets/Cupcake_128_Part-1.png"),
	#preload("res://Assets/Temporary/Green Rectangle1.png"),
	#preload("res://Assets/Exported Art Assets/Cupcake_128_Part-2.png")
	preload("res://Assets/Exported Art Assets/Cupcake_64_Part-1.png"),
	preload("res://Assets/Exported Art Assets/Cupcake_64_Part-2.png")
]

func _ready():
	$Play.pressed.connect(play_game)
	Input.set_custom_mouse_cursor(cupcakes[0], 0, Vector2(32, 32))

func play_game():
	get_tree().change_scene_to_packed(game)

func _process(delta):
	var any_hovered:= false
	for button in buttons:
		if button.is_hovered():
			any_hovered = true
	if not is_hovered and any_hovered:
		Input.set_custom_mouse_cursor(cupcakes[1], 0, Vector2(32, 32))
		is_hovered = true
	if is_hovered and not any_hovered:
		Input.set_custom_mouse_cursor(cupcakes[0], 0, Vector2(32, 32))
		is_hovered = false

