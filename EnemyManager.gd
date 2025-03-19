extends Node

@export var enemy_scene : PackedScene
@export var player : CharacterBody2D


func _ready():
	pass

func _process(delta):
	if(get_tree().get_nodes_in_group("enemy").size() == 0):
		var enemy = enemy_scene.instantiate() as CharacterBody2D
		var entities_layer = get_tree().get_first_node_in_group("entities")
		entities_layer.add_child(enemy)
		enemy.global_position = Vector2(player.global_position.x + 2000, 492)



