extends Node3D

@onready var pos = $Marker3D

@onready var room1 = preload("res://scenes/rooms/test/R1.tscn")
@onready var room2 = preload("res://scenes/rooms/test/R2.tscn")
@onready var room3 = preload("res://scenes/rooms/test/R3.tscn")

@export var r_array : Array[PackedScene]
@export var offset : Array[Vector3]
@export var rooms = 15

var roomRandomizer = RandomNumberGenerator.new()
var instantiated = false

@export var player : NodePath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var new_pos : Vector3 = pos.position
	
	for r in rooms:
		var new_id = roomRandomizer.randi_range(0,2)
		var new_room = r_array[new_id].instantiate()
		$NavigationRegion3D.add_child(new_room)
		new_room.position = new_pos
		var new_offset = offset[randi_range(0,1)]
		new_pos = new_room.position + new_offset



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
