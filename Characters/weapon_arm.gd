extends Node2D

class_name WeaponArm

@export var Bullet : PackedScene

@export var max_rotation_up = -1
@export var max_rotation_down = 1.8
@export var cooldown = 1.00
@onready var animator = $AnimationPlayer

var shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	# look_at(mouse_pos)
	
	var angle = atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
	
	rotation = angle
	
	if angle > max_rotation_up && angle < max_rotation_down:
		scale.y = 1
		get_parent().flip(1)
	else:
		scale.y = -1
		get_parent().flip(-1)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	if shooting:
		return
	shooting = true
	animator.play("Shoot")

	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.global_transform = $Muzzle.global_transform
	
	await animator.animation_finished
	animator.play("Idle")
	await get_tree().create_timer(cooldown).timeout
	shooting = false

