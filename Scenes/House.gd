extends Node2D
class_name House


var cupcake:= load("res://Assets/Exported Art Assets/Cupcake.png")

func _ready():
	Input.set_custom_mouse_cursor(cupcake)

