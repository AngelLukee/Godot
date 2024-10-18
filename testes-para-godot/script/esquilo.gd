extends CharacterBody2D

const speed = 50
const gravity = 800
enum states {moving, idle, falling, time_waiting, waiting, fling, shooting}
var state = states.waiting
var direction = -1
@onready var timer: Timer = $Timer
@onready var esquilo: CharacterBody2D = $"."
var bulletpath = preload("res://scenes/nuts.tscn")



func _physics_process(_delta):
	match state:
		states.idle:
			idle()
		states.moving:
			moving()
		states.falling:
			falling(_delta)
		states.fling:
			fling()
		states.waiting:
			velocity.y = 0
		states.shooting:
			shooting()
	
	move_and_slide()
	if $detector.is_colliding():
		timer.start()

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
	if direction < 0:
		if esquilo.position.x >= 896:
			velocity.x = 0
			state = states.fling
	
	
func falling(_delta):
	$Colide_Right.enabled = false
	velocity.y += gravity * _delta
	if is_on_floor():
		velocity.x = 0 
		timer.start()
		state = states.time_waiting
		
func fling():
	
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.CRIMSON, 4)
	await tween.finished
	velocity.y = -speed
	if esquilo.position.y <= 470:
		velocity.y = 0
		state = states.shooting

func shooting():
	var bullet = bulletpath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = Vector2(0, 40)
	var tween = create_tween()
	tween.tween_property($".", "rotation", 2, 3)
	tween.tween_property($".", "rotation", -2, 3)
	


func _on_timer_timeout() -> void:
	state = states.idle
	$detector.enabled = false
