extends Node

@onready var camera2d = $Player/Camera2D
@onready var ground = $%Ground
var screen_size : Vector2i
var ground_instance = preload("res://scene/game_object/ground/ground.tscn")
var z_initial = 0
var black_platform : CollisionObject2D
@onready var label = $GameCam/Label

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	label.text = str(Score.score)





#func _process(delta):
	#screen_size = get_window().size
	##print(camera2d.global_position.x - ground.global_position.x)
	#var ground_scene = ground_instance.instantiate()
	#if camera2d.global_position.x - ground.global_position.x >  screen_size.x * 1.5 :
		#add_child(ground_scene)
		#ground_scene.global_position = ground.global_position
		#ground_scene.global_position.x = ground.global_position.x + screen_size.x + 4618
		#z_initial += 1
		#ground_scene.z_index = z_initial
#
#
	#elif camera2d.global_position.x - ground.global_position.x <= screen_size.x / 1.5:
#
		#add_child(ground_scene)
		#ground_scene.global_position = ground.global_position
		#ground_scene.global_position.x = ground.global_position.x - 4618
		#z_initial += 1
		#ground_scene.z_index = z_initial
#
	#ground.global_position = ground_scene.global_position
#
