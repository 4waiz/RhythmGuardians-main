extends Node


@export var platform_combo_1 = PackedScene
@export var platform_combo_2 = PackedScene
@export var platform_combo_3 = PackedScene
@export var platform_combo_4 = PackedScene
@export var black_platform = PackedScene
var entities_layer : Node
var player = Node2D
var ground = Node2D
var platform_table = WeightedTable.new()
@export var goal_area : Area2D

func _ready():
	entities_layer = get_tree().get_first_node_in_group("entities")
	player = get_tree().get_first_node_in_group("player")

	platform_table.add_item(platform_combo_1, 10)
	platform_table.add_item(platform_combo_2, 10)
	platform_table.add_item(platform_combo_3, 10)
	platform_table.add_item(platform_combo_4, 10)
	platform_table.add_item(black_platform, 10)

func _process(delta):
	ground = get_tree().get_first_node_in_group("ground")
	if(get_tree().get_nodes_in_group("platform_combo").size() == 0 && platform_table.weight_sum > 0):
		var platform_scene = platform_table.pick_item()
		var platform_combo = platform_scene.instantiate() as Node2D
		entities_layer.add_child(platform_combo)
		platform_combo.global_position.x = player.global_position.x + 1080
		if platform_combo.is_in_group("pf4"): #for some reason the 4th combo is always higher
			platform_combo.global_position.y = ground.global_position.y + 600
		else:
			platform_combo.global_position.y = ground.global_position.y + 500
	else:
		var platform_scene = get_tree().get_first_node_in_group("platform_combo") as Node2D
		if platform_scene.global_position.x + 1050 < goal_area.global_position.x:
			platform_scene.queue_free()
