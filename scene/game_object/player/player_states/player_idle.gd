extends State
class_name PlayerIdle
@export var player: CharacterBody2D
@onready var velocity_component = $"../../VelocityComponent"
@onready var animated_sprite_2d = $%AnimatedSprite2D




func Physics_Update(delta):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_down"):
		transitioned.emit(self,"moving")
	if Input.is_action_pressed("jump"):
		transitioned.emit(self,"jumping")
#
	#velocity_component.accelerate_to_player_feet(tackleposition, tackleflag)
#
	#velocity_component.move(enemy)


func Enter():
	animated_sprite_2d.play("idle")


func Exit():
	pass
