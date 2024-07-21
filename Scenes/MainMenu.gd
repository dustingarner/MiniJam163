extends Node2D


func _ready():
	$Play.pressed.connect(func(): get_tree().change_scene_to_file("res://Scenes/House.tscn"))

