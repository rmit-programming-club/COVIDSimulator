extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0
export var people = 0
export var max_people = 100
var time_until_double = 20
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func person_masked():
	people -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if log(people) / log(2) < time / time_until_double and people < max_people:
		var newPerson = load("res://Scenes/Enemy.tscn").instance()
		add_child(newPerson)
		var playerPos = $Player.get_position()
		var randomDirection = Vector2(rng.randf_range(-10.0, 10.0)
, rng.randf_range(-10.0, 10.0)).normalized()
		var distance =200
		newPerson.set_position(playerPos + distance * randomDirection )
		people += 1
