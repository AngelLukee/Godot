extends CharacterBody2D

const speed = 200
const jumping = 180
const gravity = 800

enum States {idle, running, jumping, falling, waiting}

var state = States.idle

func _physics_process(_delta):
	match state:
		States.idle:
			idle()
		States.running:
			running()
		States.jumping:
			_jumping()
		States.falling:
			falling(_delta)
	
	
	move_and_slide()
	
func idle():
	velocity.x = 0
	if Input.get_axis("left", "right"):
		state = States.running
	if Input.is_action_pressed("jump"):
		state = States.jumping
	
func running():
	var direction = Input.get_axis("left", "right")
	if direction and is_on_floor():
		velocity.x = direction * speed
	else:
		velocity.x = 0
	if !Input.get_axis("left", "right"):
		state = States.idle
	if Input.is_action_pressed("jump") and is_on_floor():
		state = States.jumping
	if not is_on_floor():
		state = States.falling


func _jumping():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jumping
	if not is_on_floor():
		state = States.falling

func falling(_delta):
	velocity.y += gravity * _delta
	if is_on_floor():
		state = States.idle
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0
