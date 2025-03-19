extends State
class_name PlayerJumping
@export var player: CharacterBody2D
@onready var velocity_component = $"../../VelocityComponent"
@onready var animated_sprite_2d = $%AnimatedSprite2D




func Physics_Update(delta):
	if player.is_on_floor():
		transitioned.emit(self,"idle")
	if Input.is_action_pressed("move_right"):
		animated_sprite_2d.flip_h = false
	elif Input.is_action_pressed("move_left"):
		animated_sprite_2d.flip_h = true
	#velocity_component.accelerate_to_player_feet(tackleposition, tackleflag)
#
	#velocity_component.move(enemy)


func Enter():
	animated_sprite_2d.play("jump")


func Exit():
	pass



