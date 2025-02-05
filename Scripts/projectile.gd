extends Node3D
@export var SPEED: float = 20
var stop : float = 0
var element = "fire"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("proj")
	if element == "fire":
		$fire.emitting = true
	else:
		$ice.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED+stop) * delta




func _on_timer_timeout() -> void:
	queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	queue_free()
