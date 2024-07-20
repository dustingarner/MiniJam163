extends Area2D


func _ready():
	collision_mask = Collision.TELEPORTER
	collision_layer = Collision.TELEPORT_INDICATOR

func _process(delta):
	global_position = get_viewport().get_mouse_position()
