extends CharacterBody2D


@onready var animation = $"animação_boneco"
var speed = 140
const jumping = 200
const gravity = 800
enum States {idle, running, jumping, falling, waiting}
var waiting
var state = States.idle
const bulletpath = preload("res://scenes/nuts.tscn")




func _process(delta: float) -> void:
	pass


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
		waiting:
			pass
			
	move_and_slide()
	
func idle():
	velocity.x = 0
	animation.play("idle")
	if Input.get_axis("left", "right"):
		state = States.running
	if Input.is_action_pressed("jump"):
		state = States.jumping
	if not is_on_floor():
		state = States.falling
	
func running():
	var direction = Input.get_axis("left", "right")
	if direction and is_on_floor():
		velocity.x = direction * speed
		animation.play("running")
	else:
		velocity.x = 0
	if !Input.get_axis("left", "right"):
		state = States.idle
	if Input.is_action_pressed("jump") and is_on_floor():
		state = States.jumping
	if not is_on_floor():
		state = States.falling
	
	if direction == -1:
		$sprites_boneco.flip_h = true
	elif direction == 1:
		$sprites_boneco.flip_h = false


func _jumping():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jumping
	if not is_on_floor():
		state = States.falling
		animation.play("jumping")
		
func falling(_delta):
	velocity.y += gravity * _delta
	animation.play("falling")
	if is_on_floor():
		state = States.idle
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0

func shotting():
	pass

func raycast():
	pass
	
