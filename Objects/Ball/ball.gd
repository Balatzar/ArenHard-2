extends RigidBody2D

@export var engine_thrust = 500
@export var spin_thrust = 15000

var thrust = Vector2()
var rotation_dir = 0
var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size

func get_input():
	rotation_dir = 0
	var dirs = [-1, 1]
	rotation_dir -= dirs[randi() % dirs.size()]

func _process(delta):
	get_input()

func _physics_process(delta):
	apply_force(thrust)
	apply_torque(rotation_dir * spin_thrust)
