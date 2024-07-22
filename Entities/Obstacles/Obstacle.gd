extends StaticBody2D
class_name Obstacle

func _ready():
	collision_layer = Collision.OBSTACLE
	collision_mask = Collision.GRANDMA
