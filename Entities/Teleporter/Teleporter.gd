extends Area2D
class_name Teleporter

var location: Vector2
var can_teleport:= true

func _ready():
	collision_layer = Collision.TELEPORTER
	collision_mask = Collision.TELEPORT_INDICATOR
	z_index = -1
	location = $Marker2D.global_position
