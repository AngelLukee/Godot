extends CharacterBody2D


const speed = 50
const gravity = 800
enum states {moving, idle, falling, time_waiting, waiting, fling, shooting}
var state = states.waiting
var direction = -1
@onready var esquilo: CharacterBody2D = $"."
var bulletpath = preload("res://scenes/nuts.tscn")
@onready var shoot : Timer = $shooting
@onready var mira_player: RayCast2D = $mira_player
@onready var opa = $"."
@onready var player = get_tree().get_first_node_in_group("boneco")

func _ready() -> void:
	var mirando : Vector2 = $mira_player.position
	direction = global_position.direction_to(player.global_position)
	$mira_player.target_position = direction
	
	
	
func _physics_process(_delta):
	match state:
		states.idle:
			idle()
			$Label.text = "idle"
		states.moving:
			moving()
			$Label.text = "idle"
		states.falling:
			falling(_delta)
			$Label.text = "falling"
		states.fling:
			fling()
			$Label.text = "fly"
		states.waiting:
			$mira_player.target_position.x = player.position.x
		states.shooting:
			shooting()
			$Label.text = "shoot"
	
	move_and_slide()
	var direction_to_player = global_position.direction_to(player.global_position)
	$mira_player.cast_to = direction_to_player 
	$mira_player.force_raycast_update()
	var collision_object = $mira_player.get_collider()
	
	if $detector.is_colliding():
		state = states.idle
		$detector.enabled = false

func idle():
	
	if not is_on_floor():
		state = states.falling
	if is_on_floor():
		velocity.x = direction * speed
	
	if $Colide_Left.is_colliding():
		state = states.moving
		

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
	
	velocity.y += gravity * _delta
	if is_on_floor():
		velocity.y = 0 
		state = states.idle
		
func fling():
	velocity.x = 0
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.CRIMSON, 2)
	await tween.finished
	velocity.y = -speed
	
	if esquilo.position.y <= 470:
		shoot.start()
		velocity.y = 0
		
func shooting():
	
	print("aqui")
	var bullet = bulletpath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Marker2D.global_position
	

func _on_shooting_timeout() -> void:
	print("here")
	state = states.shooting
