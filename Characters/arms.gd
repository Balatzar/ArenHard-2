extends Node2D

class_name Arms

@export var max_rotation_up = -1
@export var max_rotation_down = 1.8

@onready var animator = $Animator

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	# look_at(mouse_pos)
	
	var angle = atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
	
	if angle > max_rotation_up && angle < max_rotation_down:
		get_parent().flip(1)
	else:
		get_parent().flip(-1)
