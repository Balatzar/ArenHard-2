extends Sprite2D

@export var Bullet : PackedScene

@export var max_rotation_up = -1
@export var max_rotation_down = 1.8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	print(rotation)
	# look_at(mouse_pos)
	
	var angle = atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
	
	rotation = angle
	if angle > max_rotation_up && angle < max_rotation_down:
		print("no rotato")
		scale.y = 1
		owner.flip(1)
		# rotation = angle + .5
	else:
		print("rotato")
		scale.y = -1
		owner.flip(-1)
		# rotation = angle - .5
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = Bullet.instantiate()
	print(owner.owner)
	owner.owner.add_child(bullet)
	bullet.transform = $Muzzle.transform
