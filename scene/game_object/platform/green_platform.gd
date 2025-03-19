extends StaticBody2D
@onready var green_platform = $"."
@onready var gpu_particles_2d = $GPUParticles2D

signal scoreplus

var checkedbefore = false
@onready var collision_check = $CollisionCheck

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_check.body_entered.connect(on_body_entered) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_body_entered(body: Node2D):
	await get_tree().create_timer(.5).timeout

	if get_tree().get_first_node_in_group("player").global_position.y < green_platform.global_position.y:
					Score.score +=1
	else:
			pass
