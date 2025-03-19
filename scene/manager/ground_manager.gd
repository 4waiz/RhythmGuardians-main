extends Node
@export var first_ground : StaticBody2D
@export var player : CharacterBody2D
var ground_instance = preload("res://scene/game_object/ground/ground.tscn")
var initial_ground: StaticBody2D
var ground_width : float



func _ready():
	initial_ground = first_ground
	ground_width = initial_ground.get_ground_size().x

func _process(delta):
	var distance_of_player = abs(player.global_position.x - initial_ground.global_position.x)

	if distance_of_player > (ground_width/2.0 + 200) :
		var ground_scene = ground_instance.instantiate()
		add_child(ground_scene)
		ground_scene.global_position = Vector2(initial_ground.global_position.x + ground_width + 5, initial_ground.global_position.y)
		#ground_scene.global_position.x = ground.global_position.x + screen_size.x + 4618
	elif distance_of_player < (ground_width/2.0 -200):
		var ground_scene = ground_instance.instantiate()
		add_child(ground_scene)
		ground_scene.global_position = Vector2(initial_ground.global_position.x - ground_width + 5, initial_ground.global_position.y)
	get_closest_ground()



func get_closest_ground():
	var grounds = get_tree().get_nodes_in_group("ground")
	grounds.sort_custom(func(a: Node2D, b:Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	initial_ground = grounds[0]

	var counter = 0
	for ground in grounds:
		counter += 1
		if counter > 3 && grounds.size() > 3:
			grounds[counter-1].queue_free()
			counter = 3

