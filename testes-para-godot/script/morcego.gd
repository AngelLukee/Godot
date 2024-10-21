extends CharacterBody2D

enum states {idle, fling, chasing}
var state = states.idle
var ondas = preload("res://scenes/ondas.tscn")
var opa = 0


func _physics_process(_delta):
	while (4 > opa):
		var waves = ondas.instantiate()
		get_parent().add_child(waves)
		waves.position = $"../primeiro marcador".global_position
		opa += 1
		print("foi")
		var tween = create_tween()
		tween.tween_property(waves, "scale", Vector2(4,4), 3)
