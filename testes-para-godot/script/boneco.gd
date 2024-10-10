extends CharacterBody2D

@onready var animation: AnimationPlayer = $"animação_boneco"
var speed = 100
const jumping = 180
const gravity = 600
var sprint = false
var sword = false
var equiped = false
var attack = false



func _ready():
	$sword_area/sword_collision.disabled = true
	$punch_area/punch_collision.disabled = true


func _physics_process(_delta):
	if sword == false:
		movement()
	elif sword == true:
		equip_sword()
		
	_sprint(_delta)
	equips()
	move_and_slide()
	
	
func movement():
	var direction = Input.get_axis("left", "right")
	if direction and attack == false:
		velocity.x = direction * speed
		if is_on_floor() and sprint == false:
			animation.play("walking")
	elif is_on_floor() and attack == false:
		velocity.x = 0
		animation.play("idle")
		
	if direction == -1:
		$sprites_boneco.flip_h = true
	elif direction == 1:
		$sprites_boneco.flip_h = false
	
	if Input.is_action_just_pressed("attack"):
		animation.play("punch_attack")
		velocity.x = 0
		attack = true
		
func _sprint(_delta):
	if Input.is_action_pressed("sprint") and velocity.x != 0:
		speed = 200
		sprint = true
		if is_on_floor() and sword == false:
			animation.play("running")
		elif is_on_floor() and sword == true:
			animation.play("sword_run")
	elif Input.is_action_just_released("sprint"):
		sprint = false
		speed = 100
	
	if !is_on_floor():
		velocity.y += gravity * _delta 
	if is_on_floor() and Input.is_action_just_pressed("jump") and attack == false:
		velocity.y = -jumping
		animation.play("jumping")

func equips():
	if equiped == true:
		if Input.is_action_just_pressed("sword"):
			sword = true
		elif Input.is_action_just_pressed("hands"):
			sword = false
			
func equip_sword():
	var direction = Input.get_axis("left", "right")
	if direction and attack == false:
		velocity.x = direction * speed
		if is_on_floor() and sprint == false:
			animation.play("walking")
	elif is_on_floor() and attack == false:
		velocity.x = 0
		animation.play("sword_idle")
	
	if direction == -1:
		$sprites_boneco.flip_h = true
	elif direction == 1:
		$sprites_boneco.flip_h = false
	
	if Input.is_action_just_pressed("attack"):
		animation.play("sword_attack")
		velocity.x = 0
		attack = true
	
func _on_animação_boneco_animation_finished(anim_name: StringName) -> void:
	if anim_name == "sword_attack":
		attack = false
	elif anim_name == "punch_attack":
		attack = false
