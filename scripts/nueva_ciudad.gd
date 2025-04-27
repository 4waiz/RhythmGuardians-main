extends Node2D

# preload dialogs
var abuelita_scene = preload("res://scenes/dialogos/dialogo_abuelita.tscn")
var mickey_scene = preload("res://scenes/dialogos/dialogo_mickey.tscn")
var inimputable_scene = preload("res://scenes/dialogos/dialogo_inim.tscn")
var infidelidad_scene = preload("res://scenes/dialogos/dialogo_infelidad.tscn")
var diegote_scene = preload("res://scenes/dialogos/dialogo_diegote.tscn")

# preload pause menu
var escena_pausa = preload("res://scenes/pausa/control.tscn")

# track player interaction
var personaje_en_area = false
var casa = ""

# track which houses were visited
var casas = {
	"abuelita": false,
	"infidelidad": false,
	"mickey": false,
	"diegote": false
}

func _process(_delta: float) -> void:
	if personaje_en_area:
		get_tree().call_group("Policia", "detener_policias")
	else:
		get_tree().call_group("Policia", "renaudar_policias")
	
	if Input.is_action_just_pressed("interactuar") and personaje_en_area:
		_interactuar()
	
	if Input.is_action_just_pressed("ui_cancel"):
		var escena = escena_pausa.instantiate()
		add_child(escena)
		get_tree().paused = true

func _interactuar() -> void:
	match casa:
		"abuelita":
			if not casas["abuelita"]:
				casas["abuelita"] = true
				abrir_dialogo(abuelita_scene)
				get_tree().call_group("Player", "modificar_high", -10)
		"inimputable":
			abrir_dialogo(inimputable_scene)
		"infidelidad":
			if not casas["infidelidad"]:
				casas["infidelidad"] = true
				abrir_dialogo(infidelidad_scene)
				get_tree().call_group("Player", "modificar_high", -10)
		"mickey":
			if not casas["mickey"]:
				casas["mickey"] = true
				abrir_dialogo(mickey_scene)
				get_tree().call_group("Player", "modificar_high", +10)
		"diegote":
			if not casas["diegote"]:
				casas["diegote"] = true
				abrir_dialogo(diegote_scene)
				get_tree().call_group("Player", "modificar_high", +20)
		"casa":
			if Autoload.llave:
				Autoload.win_game()

func abrir_dialogo(escena) -> void:
	var instancia = escena.instantiate()
	add_child(instancia)
	get_tree().call_group("Player", "stop_player")

# body entered handlers
func _on_lava_platos_body_entered(body: Node2D) -> void:
	_area_entered(body, "abuelita", $LavaPlatos/Label)

func _on_mickey_body_entered(body: Node2D) -> void:
	_area_entered(body, "mickey", $Mickey/Label)

func _on_inimputable_body_entered(body: Node2D) -> void:
	_area_entered(body, "inimputable", $Inimputable/Label)

func _on_infidelidad_body_entered(body: Node2D) -> void:
	_area_entered(body, "infidelidad")

func _on_diegote_body_entered(body: Node2D) -> void:
	_area_entered(body, "diegote", $Diegote/Label)

func _on_casa_body_entered(body: Node2D) -> void:
	_area_entered(body, "casa", $Casa/Label)

# body exited handlers
func _on_lava_platos_body_exited(body: Node2D) -> void:
	_area_exited(body, $LavaPlatos/Label)

func _on_mickey_body_exited(body: Node2D) -> void:
	_area_exited(body, $Mickey/Label)

func _on_inimputable_body_exited(body: Node2D) -> void:
	_area_exited(body, $Inimputable/Label)

func _on_infidelidad_body_exited(body: Node2D) -> void:
	_area_exited(body)

func _on_diegote_body_exited(body: Node2D) -> void:
	_area_exited(body, $Diegote/Label)

func _on_casa_body_exited(body: Node2D) -> void:
	_area_exited(body, $Casa/Label)

# generic enter/exit helper functions
func _area_entered(body: Node2D, nombre_casa: String, label: Label = null) -> void:
	if body.is_in_group("Player"):
		personaje_en_area = true
		casa = nombre_casa
		if label:
			label.visible = true

func _area_exited(body: Node2D, label: Label = null) -> void:
	if body.is_in_group("Player"):
		personaje_en_area = false
		if label:
			label.visible = false
