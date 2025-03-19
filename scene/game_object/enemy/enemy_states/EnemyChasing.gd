extends State
class_name EnemyChasing
@export var enemy: CharacterBody2D
@onready var velocity_component = $"../../VelocityComponent"
var tackleposition = 0.0
var tackleflag = false
@onready var tackle_area = $%TackleArea
@onready var animated_sprite_2d = $%AnimatedSprite2D
@onready var gpu_particles_2d = $"../../GPUParticles2D"


func Physics_Update(delta):


	velocity_component.accelerate_to_player()
	velocity_component.move(enemy)
	var distance_to_player = enemy.global_position.x - get_tree().get_first_node_in_group("player").global_position.x
	if distance_to_player <= 500:
		transitioned.emit(self, "tackling")

func Enter():
	animated_sprite_2d.play("default")
func Exit():
	animated_sprite_2d.play("idle")
	var tween = create_tween() #little bounce before tackling

	tween.tween_property(enemy, "global_position:y", enemy.global_position.y-20,0.2).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(enemy, "global_position:y", enemy.global_position.y+20,0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BOUNCE)

	#tackle_area.area_entered.connect(on_tackle_area_entered)
#
#
#func on_tackle_area_entered(area: Area2D):
	#transitioned.emit(self, "tackling")
