extends Area2D

var matchTimer = Timer.new()

func _ready():
	setUpTimers()

func setUpTimers():
	matchTimer.connect("timeout", Callable(self, "_on_timer_timeout"))
	matchTimer.set_one_shot(true)
	add_child(matchTimer)

func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$AudioLlave.play()
		matchTimer.start(0.5)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/victoria/victoria.tscn")
