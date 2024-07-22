extends Node2D

@onready var button:= $CanvasLayer/TextureButton

func _ready():
	button.pressed.connect(toggle_fullscreen)

func _input(event):
	if event.is_action_pressed("esc"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func toggle_fullscreen():
	button.release_focus()
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
