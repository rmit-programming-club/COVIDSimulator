extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var caught_count = 0
var time_left = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_left -= delta
	var direction = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		$AnimatedSprite.play("Walk right")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		direction.x += 1
		$AnimatedSprite.play("Walk right")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		$AnimatedSprite.play("Walk down")
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		$AnimatedSprite.play("Walk up")
	else:
		$AnimatedSprite.stop()
	var speed = 100
	var velocity = speed * direction
	move_and_slide(velocity)
	$CanvasLayer/VBoxContainer/TimeLeft.text = "Time Left: " + str(int(time_left))
	if time_left < 0:
		var endGame = load("res://Scenes/EndGame.tscn").instance()
		endGame.set_score(caught_count)
		get_tree().get_root().get_node("Scene").queue_free()
		get_tree().get_root().add_child(endGame)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		print(collider.name)
		if collider.is_in_group("enemy"):
			collider.mask()
			caught_count += 1
			$Camera2D.SHAKE()
			$AudioStreamPlayer2D.play()
			get_parent().person_masked()
			$CanvasLayer/VBoxContainer/CaughtCount.text = "Caught: " + str(caught_count)

