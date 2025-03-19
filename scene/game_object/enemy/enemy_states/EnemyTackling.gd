extends State
class_name EnemyTackling
@export var enemy: CharacterBody2D
@onready var velocity_component = $"../../VelocityComponent"
var tackleposition = 0.0
var tackleflag = false
@onready var tackle_area = $%TackleArea
@onready var animated_sprite_2d = $%AnimatedSprite2D
@onready var gpu_particles_2d = $"../../GPUParticles2D"
@onready var tackle_timer = %TackleTimer
var player : CharacterBody2D
@onready var collision_shape_2d = %CollisionShape2D

func Physics_Update(delta):

	velocity_component.accelerate_to_player_feet(tackleposition, tackleflag)
	velocity_component.move(enemy)
	player = get_tree().get_first_node_in_group("player")
	if(player.global_position.x > enemy.global_position.x && tackle_timer.time_left == 0):
		tackle_timer.start()


func Enter():
	tackle_timer.timeout.connect(on_tackle_timer_timeout)

	tackleflag = true
	tackleposition = get_tree().get_first_node_in_group("player").global_position.x
	var tween = create_tween()
	#tween.tween_property(enemy, "global_position:y", enemy.global_position.y-10,0.1).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(animated_sprite_2d,"rotation",deg_to_rad(85),0.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	animated_sprite_2d.play("tackle")
	gpu_particles_2d.emitting = true
	await get_tree().create_timer(2).timeout
	gpu_particles_2d.emitting = false
	await get_tree().create_timer(3).timeout
	tackleflag=false
	animated_sprite_2d.play("default")


func on_tackle_timer_timeout():
	animated_sprite_2d.position.y += 5
	collision_shape_2d.disabled = true
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2.ZERO, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	enemy.queue_free()



