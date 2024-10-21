extends CharacterBody2D

const speed = 900

func _physics_process(delta):
	var collision = move_and_collide(speed * delta)
	if collision:
		queue_free()
