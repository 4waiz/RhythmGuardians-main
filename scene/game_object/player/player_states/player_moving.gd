extends State
class_name PlayerMoving
@export var player: CharacterBody2D
@onready var velocity_component = $"../../VelocityComponent"
@onready var animated_sprite_2d = $%AnimatedSprite2D
@onready var hurtbox_collision = %HurtBoxCollision
@onready var terrain_collider = $"../../TerrainCollider"

var hurtbox_initial_position = Vector2.ZERO
var hurtbox_initial_scale = Vector2.ZERO
var hurtbox_modified_position = hurtbox_initial_position

#Collision Shape Modifiers
var up_left_collision_shape_position = Vector2(-1.5, 0.5)
var up_collision_shape_size = Vector2(7.012,18.019)
var up_right_collision_shape_position = Vector2(1.5,0.5)
var down_collision_shape_size = Vector2(8.414,14.839)
var down_right_collision_shape_position = Vector2(3,1)
var down_left_collision_shape_position = Vector2(-3,1)


func Physics_Update(delta):
	animation_handling()
	collision_box_modifier()



func Enter():
	animated_sprite_2d.play("run")


func Exit():
	pass


func animation_handling():
	if Input.is_action_pressed("move_down"):
		animated_sprite_2d.play("duck")
	elif !player.is_on_floor():
		transitioned.emit(self,"jumping")
	elif Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
		animated_sprite_2d.play("run")
	else:
		transitioned.emit(self,"idle")
	if Input.is_action_pressed("move_right"):
		animated_sprite_2d.flip_h = false
	elif Input.is_action_pressed("move_left"):
		animated_sprite_2d.flip_h = true

func collision_box_modifier():

	if animated_sprite_2d.flip_h: #definitely moving left
		if Input.is_action_pressed("move_down"):
			hurtbox_collision.shape.size = down_collision_shape_size
			hurtbox_collision.position = down_left_collision_shape_position
			terrain_collider.scale.y= .75
			terrain_collider.position.y = 2

			return
		else:
			hurtbox_collision.position = up_left_collision_shape_position
			hurtbox_collision.shape.size = up_collision_shape_size
			terrain_collider.scale = Vector2(0.986, 0.965)
			terrain_collider.position.y = .5
			return
	else:
		if Input.is_action_pressed("move_down"):
			hurtbox_collision.position = down_right_collision_shape_position
			hurtbox_collision.shape.size = down_collision_shape_size
			terrain_collider.scale.y= .75
			terrain_collider.position.y = 2
			return
		else:
			hurtbox_collision.position = up_right_collision_shape_position
			hurtbox_collision.shape.size = up_collision_shape_size
			terrain_collider.scale = Vector2(0.986, 0.965)
			terrain_collider.position.y = .5
			return
