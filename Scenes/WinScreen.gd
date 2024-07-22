extends Node2D

@export var is_win:= true

func _ready():
	if is_win:
		GameAudio.start_song(GameAudio.success)
	else:
		GameAudio.start_song(GameAudio.failure)
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

