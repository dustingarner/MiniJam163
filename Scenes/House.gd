extends Node2D
class_name House


@onready var bar:= $Timer/Bar
@onready var bar_end_position:= $Timer/EndPos

const LERP_SPEED:= 0.01

var cupcake:= load("res://Assets/Exported Art Assets/Cupcake_64_Part-1.png")
var win_screen:= preload("res://Scenes/WinScreen.tscn")
var coma_count:= 0
var start_position: Vector2
var end_position: Vector2
var lerp_weight:= 0.0

func _ready():
	Input.set_custom_mouse_cursor(cupcake)
	for child in get_children():
		if child is Child:
			child.start_coma.connect(increment_coma)
	start_position = bar.global_position
	end_position = $Timer/EndPos.global_position

func increment_coma():
	coma_count += 1
	if coma_count == 3:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(win_screen)

func fail_game():
	get_tree().change_scene_to_packed(win_screen)

func _process(delta):
	bar.global_position = lerp(start_position, end_position, lerp_weight)
	if lerp_weight == 1.0:
		fail_game()
	lerp_weight += delta * LERP_SPEED
	lerp_weight = clamp(lerp_weight, 0.0, 1.0)

