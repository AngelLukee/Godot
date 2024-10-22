extends CharacterBody2D

enum states {idle, fling, chasing}
var state = states.idle
var ondas = preload("res://scenes/ondas.tscn")
var opa = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
	
func _physics_process(_delta):
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
