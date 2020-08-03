extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var neighbourhood_size = 50
export var cohesion_co = 1
export var seperation_co = 10
export var target_co = 1
export var masked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func mask():
	masked = true
	$CollisionShape2D.disabled = true

func get_neighbourhood():
	var neighbours = []
	for enemy in get_tree().get_nodes_in_group("enemy"):
		if (enemy.get_position() - get_position()).length_squared() < neighbourhood_size * neighbourhood_size:
			neighbours.append(enemy)
	return neighbours
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_parent().get_node("Player")
	var direction = Vector2()
	direction = get_position()-player.get_position()
	if direction.length() > 400:
			get_parent().person_masked()
			queue_free()
	if masked:
		if direction.length() > 200:
			queue_free()
		direction = direction.normalized()
	else:
		var neighbourhood = get_neighbourhood()
		var seperation = Vector2(0,0)
		var center = Vector2(0,0)
		for neighbour in neighbourhood:
			center += neighbour.get_position()
		var cohesion = (center/len(neighbourhood) - get_position())
		
		var target = -(player.position - get_position())
		if target.length_squared() < 2500:
			direction = (target * target_co).normalized()
		else:
			direction = (cohesion * cohesion_co).normalized()
	
	
	if direction.length() > 0.5:
		var speed = 50
		var mode = "Walk"
		if masked:
			mode = "Masked"
		if direction.y >= 0.5:
			$AnimatedSprite.play(mode + " down")
		elif direction.y <= -0.5:
			$AnimatedSprite.play(mode + " up")
		elif direction.x >= 0.5:
			$AnimatedSprite.play(mode + " right")
			$AnimatedSprite.flip_h = false
		elif direction.x <= -0.5:
			$AnimatedSprite.play(mode + " right")
			$AnimatedSprite.flip_h = true
		move_and_slide(direction * speed)
