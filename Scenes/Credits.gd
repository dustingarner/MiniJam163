extends Node2D


func _ready():
	$Back.pressed.connect(GameAudio.play_crunch)
	$Back.pressed.connect(go_to_main)

func go_to_main():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _input(event):
	if event.is_action_pressed("esc"):
		go_to_main()
