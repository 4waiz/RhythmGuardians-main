extends Node

var llave = false

func game_over():
	call_deferred("_change_scene", "res://scenes/Muerte/control.tscn")

func _change_scene(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
