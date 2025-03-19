extends Camera2D
@export var player: CharacterBody2D
const SMOOTHING_VARIABLE = 20
var temp_position := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()
	self.global_position = player.global_position
	temp_position = global_position# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.is_player_walking_back():
		pass
	elif player.global_position.x >= temp_position.x :
		self.global_position = global_position.lerp(Vector2(player.global_position.x,self.global_position.y), 1.0 - exp(-delta * SMOOTHING_VARIABLE))
		temp_position = global_position
