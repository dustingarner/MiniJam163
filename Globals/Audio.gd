extends Node
class_name Audio

@onready var music:= $Music

func _ready():
	music.play()
	music.finished.connect(func(): music.play())


