extends CharacterBody2D

signal tackleflag
signal player_died

const SPEED = 500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ball_dribbling := false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurtbox_collision = %HurtBoxCollision
@onready var left_collision = %LeftCollision
@onready var duck_right_collision = %DuckRightCollision
@onready var duck_left_collision = %DuckLeftCollision
@onready var hurt_box = $HurtBox
@onready var velocity_component = $VelocityComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	hurt_box.body_entered.connect(on_hurtbox_entered)
	$TackleFlag.area_entered.connect(on_tackle_area_entered)

func on_hurtbox_entered(body: Node2D):
	if body.is_in_group("enemy"):
		die()

func on_tackle_area_entered():
	tackleflag.emit()

func is_player_walking_back():
	return animated_sprite_2d.flip_h

func die():
	player_died.emit()
	queue_free()  # Removes the player from the scene
