extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()
var size = 5.0
var shake = false
var time_until_shake = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


func SHAKE():
	time_until_shake = 0.5
	#shake = s
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time_until_shake > 0:
		var x =rng.randf_range(-size, size)
		var y = rng.randf_range(-size, size)
		set_position(Vector2(x,y))
		time_until_shake -= delta
