extends Node2D
class_name House


var cookie:= load("res://Assets/Temporary/Wall.png")
var not_cookie:= load("res://Assets/Temporary/Red Rectangle1.png")

var timer:= 0.0
var MAX_WAIT_TIME:= 1

func _ready():
	Input.set_custom_mouse_cursor(cookie)

func _process(delta):
	timer += delta
	if timer >= MAX_WAIT_TIME:
		Input.set_custom_mouse_cursor(not_cookie)
		var temp = not_cookie
		not_cookie = cookie
		cookie = not_cookie
		timer = 0.0
	

