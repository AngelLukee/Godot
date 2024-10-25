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
	pass

	
func chasing(delta):
	pass


func _on_timer_para_onda_timeout():
	var ondas1 = ondas.instantiate()
	get_parent().add_child(ondas1)
	ondas1.position = $"../segundo marcado".global_position
	ondas1.rotation = 1.0
	ondas1.velocit = Vector2(188, 222)
	var tween = create_tween()
	tween.tween_property(ondas1, "scale", Vector2(3, 3), 4.5)
	
	
	
