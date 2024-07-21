extends StaticBody2D
class_name Floor

func _ready():
	collision_layer = Collision.FLOOR
	collision_mask = Collision.GRANDMA + Collision.CHILDREN

