extends CharacterBody2D

var player_position
@onready var player = get_parent().get_node("boneco")
enum states {idle, fling, chasing}
var state = states.idle
var ondas = preload("res://scenes/ondas.tscn")
var speed = 60
var enemy_go



func _ready() -> void:
	print(position)

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta):
	match state:
		states.idle:
			idle()
		states.chasing:
			chasing(delta)
			
func idle():
	var position_idle = Vector2(727, 283)
	var going = (position_idle).normalized()
	move_and_collide(going * speed)

	
func chasing(delta):
	pass


func _on_timer_para_onda_timeout():
	var waves = ondas.instantiate()
	get_parent().add_child(waves)
	waves.position = $"../primeiro marcador".global_position
	print(waves.position)
	var tween_1 = create_tween()
	tween_1.tween_property(waves, "position", Vector2(716, 628), 2.5)
	var tween = create_tween()
	tween.tween_property(waves, "scale", Vector2(4,4), 3)
	
	var waves2 = ondas.instantiate()
	get_parent().add_child(waves2)
	waves2.position = $"../segundo marcado".global_position
	waves2.rotation = -30.5
	var tween2_1 = create_tween()
	tween2_1.tween_property(waves2, "position", Vector2(942, 628), 3)
	var tween2 = create_tween()
	tween2.tween_property(waves2, "scale", Vector2(4,4), 3)
