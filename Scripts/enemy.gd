extends CharacterBody3D

var projectile = load("res://scenes/projectile.tscn")
var element = "ice"
@export var canshoot = false

var SPEED = 2
#var player = null
@export var player_path : NodePath

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player = get_parent().get_parent().player
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	look_at(Global.charapos)
	#
	#player = get_node(player_path)
	velocity = Vector3.ZERO
	nav_agent.set_target_position(Global.charapos)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	move_and_slide()















func _shoot():
	var proj = projectile.instantiate()
	proj.position = global_position
	proj.transform.basis = global_transform.basis
	proj.element = element
	proj.SPEED = 90
	get_tree().root.add_child(proj)


func _on_timer_timeout() -> void:
	if canshoot:
		_shoot()
