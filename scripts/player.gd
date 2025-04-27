extends CharacterBody2D
#class_name Jugador

var speed = 150
var speed_movimiento_aleatorio = 150

@onready var timer = $"../Timer"
@onready var pickUp = $AnimatedSprite2D2
@onready var camara = $Camera2D
@onready var sprite = $AnimatedSprite2D

var animacionFinalizada = false
var estado = ""
var tiene_llave: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var high_alto = false
var stopped = false

func _ready() -> void:
	sprite.play("default")
	pickUp.hide()

func _physics_process(_delta):
	var moverIzqDer = Input.get_axis("ui_left", "ui_right")
	var moverArrAba = Input.get_axis("ui_up", "ui_down")
	var moverAmbas = Vector2(moverIzqDer, moverArrAba)
	velocity = moverAmbas.normalized() * speed

	if Input.is_action_pressed("ui_left"):
		sprite.flip_h = false
		sprite.play("lateral")
		estado = "normal"
		if high_alto:
			vibrar()
	elif Input.is_action_pressed("ui_right"):
		sprite.flip_h = true
		sprite.play("lateral")
		estado = "normal"
		if high_alto:
			vibrar()
	elif Input.is_action_pressed("ui_down"):
		sprite.play("abajo")
		estado = "down"
	elif Input.is_action_pressed("ui_up"):
		sprite.play("arriba")
		estado = "up"
	else:
		match estado:
			"down":
				sprite.play("abajoIdle")
			"up":
				sprite.play("arribaIdle")
			"normal":
				sprite.play("default")

	if not stopped:
		move_and_slide()



func vibrar():
	camara.add_trauma()


func stop_player():
	stopped = true

func resume_player():
	stopped = false
