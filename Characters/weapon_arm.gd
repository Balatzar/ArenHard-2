extends RotatingObject

class_name WeaponArm

@export var Bullet : PackedScene
@export var cooldown := 1.00


var shooting = false

func kind():
	return "weapon"

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("Idle")
	rotate = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	if get_parent().input.just_shooted:
		shoot()
		get_parent().input.just_shooted = false

func shoot():
	if shooting:
		return
	shooting = true
	animator.play("Shoot")

	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.global_transform = $Muzzle.global_transform
	
	play_sound()
	
	await animator.animation_finished
	animator.play("Idle")
	await get_tree().create_timer(cooldown).timeout
	shooting = false

func play_sound():
	# This method will be overridden in child scripts
	pass
