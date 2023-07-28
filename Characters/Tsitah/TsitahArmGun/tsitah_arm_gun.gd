extends WeaponArm

var sound = preload("res://Assets/Sounds/shot.mp3")
@onready var audioPlayer = $WeaponShot

func play_sound():
	audioPlayer.stream = sound
	# Play the sound
	audioPlayer.play()
