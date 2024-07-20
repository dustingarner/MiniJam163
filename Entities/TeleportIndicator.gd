extends Area2D
class_name TeleportIndicator

var object: CharacterBody2D

func init(_object: CharacterBody2D):
	object = _object

func _ready():
	collision_layer = Collision.TELEPORT_INDICATOR

func teleport(location: Vector2):
	object.global_position = location
