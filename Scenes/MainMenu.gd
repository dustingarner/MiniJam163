extends Node2D

var game:= preload("res://Scenes/House.tscn")

func _ready():
	$Play.pressed.connect(play_game)

func play_game():
	get_tree().change_scene_to_packed(game)

