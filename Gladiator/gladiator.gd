extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@onready var animator = get_node("Body")
@onready var arm_gun = get_node("ArmGun")
@onready var arms = get_node("Arms")
@onready var backArm = get_node("Body").get_node("ArmGun02")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#deal with the jump mechanic variables
var MAX_JUMP_TIME = 0.5
var jump_time = 0

func _ready():
	animator.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	# if direction == 1:
		# animator.scale.x = 1
		# arms.scale.x = 1
	# elif direction == -1:
		# animator.scale.x = -1
		# arms.scale.x = -1
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animator.play("Run")
			arms.play("Run")
			backArm.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animator.play("Idle")
			arms.play("Idle")
	
	if velocity.y < 0:
		animator.play("Jump")
		backArm.play("Jump")
	elif velocity.y > 0:
		animator.play("Fall")
		backArm.play("Jump")

	move_and_slide()

func take_gun():
	arm_gun.visible = true
	backArm.visible = true
	arms.visible = false

func flip(x_axis):
	animator.scale.x = x_axis
	arms.scale.x = x_axis
