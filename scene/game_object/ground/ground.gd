extends StaticBody2D

@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func get_ground_size():
	return collision_shape_2d.shape.size*self.scale
