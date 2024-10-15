extends CharacterBody2D

const speed = 75
const gravity = 800
enum states {moving, idle, falling, time_waiting, waiting}
var state = states.waiting
var direction = -1
@onready var timer: Timer = $timer


func _physics_process(_delta):
	match state:
		states.idle:
			idle()
		states.moving:
			moving()
		states.falling:
			falling(_delta)
		states.time_waiting:
			pass
	
	move_and_slide()

func idle():
	$Colide_Right.enabled = true
	velocity.x = direction * speed
	
	if $Colide_Left.is_colliding():
		state = states.moving
	if not is_on_floor():
		state = states.falling

func moving():
	
	if $Colide_Left.is_colliding():
		velocity.x = -direction * speed
	if $Colide_Right.is_colliding():
		velocity.x = direction * speed

	
	
func falling(_delta):
	$Colide_Right.enabled = false
	velocity.y += gravity * _delta
	if is_on_floor():
		velocity.x = 0 
		timer.start()
		state = states.time_waiting
		
func _on_timer_timeout():
	state = states.idle

	
