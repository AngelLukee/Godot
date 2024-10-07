extends Area2D


func _on_body_entered(_body):
	if _body is CharacterBody2D:
		_body.equiped = true
		queue_free()
