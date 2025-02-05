extends RayCast3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
var checked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not checked:
		if get_collider() != null:
			print("die" , name)
			queue_free()
		checked = true
