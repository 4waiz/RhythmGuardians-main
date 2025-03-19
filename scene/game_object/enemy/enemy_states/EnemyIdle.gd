extends State
class_name EnemyIdle
@export var enemy: CharacterBody2D
@onready var velocity_component = $"../../VelocityComponent"
var tackleposition = 0.0
var tackleflag = false
@onready var tackle_area = $%TackleArea
@onready var animated_sprite_2d = $%AnimatedSprite2D


#func Physics_Update(delta):
#
	#velocity_component.accelerate_to_player_feet(tackleposition, tackleflag)
#
	#velocity_component.move(enemy)


func Enter():
	animated_sprite_2d.play("idle")
	tackle_area.area_entered.connect(on_tackle_area_entered)

func Exit():
	pass

func on_tackle_area_entered(area: Area2D):
	#print(enemy.global_position.x - get_tree().get_first_node_in_group("player").global_position.x)
	transitioned.emit(self, "chasing")

