extends Sprite2D

@export var max_rotation_up = -45
@export var max_rotation_down = 45


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(rotation)
	print(flip_h)
	var mouse_pos = get_global_mouse_position()
	var angle = atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
	rotation = angle * 180 / PI
