extends CharacterBody3D


var SPEED = 5.0
var RUN = 0
const JUMP_VELOCITY = 4.5
var running = false
var projectile = load("res://scenes/projectile.tscn")

var atkElement = "void"
var atkCharge = 5

var bodyElement = "void"
var bodyCharge = 3


@onready var head: Camera3D = $Camera3D



func _ready() -> void:
	$Camera3D/AnimatedSprite3D.play("default")
	$Camera3D/AnimatedSprite3D2.play("default")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(rad_to_deg(-event.relative.x * 0.0001))
		head.rotate_x(rad_to_deg(-event.relative.y * 0.0001))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80),deg_to_rad(80))


func _physics_process(delta: float) -> void:
	
	print("atk", ":" ,atkElement, " ", "charge", " ", atkCharge, "     ", "zbody", ":" ,bodyElement, " ", "charge", " ",bodyCharge)
	
	if Input.is_action_just_pressed("ABSORB") and $Camera3D/RayCast3D.get_collider() !=null:
		if $Camera3D/RayCast3D.get_collider().element == "ice" or$Camera3D/RayCast3D.get_collider().element == "fire":
			atkElement = $Camera3D/RayCast3D.get_collider().element
			atkCharge = 5
		if $Camera3D/RayCast3D.get_collider().element == "earth" or$Camera3D/RayCast3D.get_collider().element == "wind":
			bodyElement = $Camera3D/RayCast3D.get_collider().element
			bodyCharge = 3
	
	if Input.is_action_just_pressed("RH"):
		if atkElement != "void" and atkCharge >= 1:
			atkCharge -= 1
			var proj = projectile.instantiate()
			proj.position = global_position
			proj.transform.basis = head.global_transform.basis
			proj.element = atkElement
			get_tree().root.add_child(proj)
	if Input.is_action_just_pressed("LH"):
		if atkElement != "void" and atkCharge >= 1:
			atkCharge -= 1
			var proj = projectile.instantiate()
			proj.position = global_position
			proj.transform.basis = head.global_transform.basis
			proj.element = atkElement
			get_tree().root.add_child(proj)
			
	if atkCharge <= 0:
		atkElement = "void"
	if bodyCharge <= 0:
		bodyElement = "void"
	
	
	Global.charapos = global_position
	
	if running:
		RUN = 3
	else:
		RUN = 0
	if Input.is_action_just_pressed("EXIT"):
		get_tree().quit() 


	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (SPEED + RUN)
		velocity.z = direction.z * (SPEED + RUN)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_pressed("SPRINT"):
		running = true
	else:
		running = false

	move_and_slide()
