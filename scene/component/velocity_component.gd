extends Node
@export var max_speed: int = 400
@export var acceleration: float = 150
@export var player: CharacterBody2D
@export var player_jump_velocity = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2.ZERO
var acc_flag = false

const PLAYER_DECELERATION_CONSTANT = 8

func _physics_process(delta):

	if player == null:
		return
	# Add the gravity.


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("move_left", "move_right")
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction !=0:
		accelerate_in_direction(Vector2(direction, 0))
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta * PLAYER_DECELERATION_CONSTANT)

	if not player.is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		velocity.y = -player_jump_velocity

	player.velocity = velocity
	player.move_and_slide()
	velocity = player.velocity


func accelerate_to_player():
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return

	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var direction = (player.global_position - owner_node2d.global_position).normalized() #returns unit vector
	#accelerate_in_direction(direction) use this if you have enemies that move vertically
	accelerate_in_direction(direction)


func accelerate_to_player_feet(tackleposition: float, tackleflag: bool):
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return

	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var direction = Vector2.ZERO
	if tackleflag:
		tackleposition = tackleposition
	else:
		tackleposition = player.global_position.x
#tween.tween_property(owner_node2d, "global_position:y", owner_node2d.global_position.y - .5,0.4).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	direction = (Vector2(tackleposition, 500) - owner_node2d.global_position).normalized()
	if owner_node2d.global_position.x - tackleposition < 3:
		pass
	else:
		accelerate_in_direction(direction)


func accelerate_in_direction(direction: Vector2):
	if owner.is_in_group("player") || owner.is_in_group("basic_enemy"):
		var desired_velocity = Vector2(direction.x * max_speed, velocity.y) # Only affect the x-component for horizontal movement
		velocity.x = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time())).x #FRAME RATE INDEPENDENT LERP
	else:
		var desired_velocity = direction * max_speed
		velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func decelerate():
	accelerate_in_direction(Vector2.ZERO)

func move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity


