extends CharacterBody2D

@onready var velocity_component = $VelocityComponent
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var collision_shape = $CollisionShape2D

var tackleposition = 0.0
var tackleflag = false

func _ready():
	$TackleArea.area_entered.connect(on_tackle_area_entered)
	add_to_group("enemy")  # Adds this enemy to the "enemy" group for collision detection

func _physics_process(delta):
	velocity_component.accelerate_to_player_feet(tackleposition, tackleflag)
	velocity_component.move(self)

func on_tackle_area_entered(area: Area2D):
	tackleflag = true
	tackleposition = get_tree().get_first_node_in_group("player").global_position.x
	
	var tween = create_tween()
	tween.tween_property(self, "global_position:y", global_position.y-50, 0.4).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(animated_sprite_2d, "rotation", deg_to_rad(85), 0.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	animated_sprite_2d.play("tackle")
	gpu_particles_2d.emitting = true
	await get_tree().create_timer(2).timeout
	gpu_particles_2d.emitting = false
	
	await get_tree().create_timer(3).timeout
	tackleflag = false
	animated_sprite_2d.play("default")
