extends Node2D

@onready var script_player = get_node("res://script/boneco.gd")
@onready var esquilo = $Esquilo

# Called when the node enters the scene tree for  the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_cena_timeout() -> void:
		$Camera2D.enabled = true
		$Esquilo/camera_esquilo.enabled = false
		

func _on_area_cena_body_entered(body: Node2D) -> void:
	$boneco/camera_Boneco.enabled = false
	$Esquilo/camera_esquilo.enabled = true
	$timer_cena.start()
	esquilo.state = esquilo.states.idle
