extends CharacterBody2D

const speed = 20

func _physics_process(_delta: float) -> void:
	velocity.y = speed
	move_and_slide()
	
