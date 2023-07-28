extends WeaponArm

#var sound = preload("res://Assets/Sounds/#.mp3")
@onready var audioPlayer = $WeaponShot

func _process(delta):
	super(delta)
	print(get_parent().input.is_shooting)
	if get_parent().input.is_shooting:
		#play_sound()	
		shoot()
	else:
		animator.play("Idle")
	
func play_sound():
	#audioPlayer.stream = sound
	# Play the sound
	audioPlayer.play()
	
func shoot():
	if shooting:
		return
	shooting = true
	animator.play("Shoot")
	
	var bullet = Bullet.instantiate()
	add_child(bullet)
	bullet.global_transform = $Muzzle.global_transform
	
	play_sound()
	
	#await animator.animation_finished
	#animator.play("Idle")
	await get_tree().create_timer(cooldown).timeout
	shooting = false
