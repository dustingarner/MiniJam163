extends Node2D
class_name House


@onready var bar:= $Timer/Bar
@onready var bar_end_position:= $Timer/EndPos

const LERP_SPEED:= 0.016

var win_screen:= preload("res://Scenes/WinScreen.tscn")
var lose_screen:= preload("res://Scenes/LoseScreen.tscn")
var coma_count:= 0
var start_position: Vector2
var end_position: Vector2
var lerp_weight:= 0.0
var all_children:= []
var mouse_dazzling:= false
var cupcakes:= [
	preload("res://Assets/Exported Art Assets/Cupcake_64_Part-1.png"),
	preload("res://Assets/Exported Art Assets/Cupcake_64_Part-2.png")
]

func _ready():
	for child in get_children():
		if child is Child:
			child.start_coma.connect(increment_coma)
			all_children.append(child)
	start_position = bar.global_position
	end_position = $Timer/EndPos.global_position

func increment_coma():
	coma_count += 1
	if coma_count == 3:
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(win_screen)

func fail_game():
	get_tree().change_scene_to_packed(lose_screen)

func check_mouse():
	var any_clickable:= false
	for child in all_children:
		if child.can_receive and child.can_click:
			any_clickable = true
			break
	if any_clickable and not mouse_dazzling:
		Input.set_custom_mouse_cursor(cupcakes[1], 0, Vector2(32, 32))
		mouse_dazzling = true
	elif not any_clickable and mouse_dazzling:
		Input.set_custom_mouse_cursor(cupcakes[0], 0, Vector2(32, 32))
		mouse_dazzling = false

func _process(delta):
	check_mouse()
	bar.global_position = lerp(start_position, end_position, lerp_weight)
	if lerp_weight == 1.0:
		fail_game()
	lerp_weight += delta * LERP_SPEED
	lerp_weight = clamp(lerp_weight, 0.0, 1.0)

