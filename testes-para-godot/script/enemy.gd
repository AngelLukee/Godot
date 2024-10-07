extends AnimatableBody2D

@onready var animation: AnimationPlayer = $animation_enemy
var vida = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_enemy_area_entered(area):
	if "sword_area" in area.name:
		if vida <= 10 and vida >= 1:
			vida -= 5
			animation.play("hurt")
			await animation.animation_finished
			animation.play("idle")
			if vida == 0:
				animation.play("death")
				await animation.animation_finished
				queue_free()
