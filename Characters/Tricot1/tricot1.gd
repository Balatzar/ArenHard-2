extends CharacterBody2D


@export var SPEED = 500.0
@export var JUMP_VELOCITY = -400
@export var JUMP_HOLD_VELOCITY = 40.0 # Additional jump velocity when holding the button
@export var MAX_JUMP_TIME = 0.50
@export_range(0.0, 1.0) var FRICTION = 0.1
@export_range(0.0 , 1.0) var ACCELERATION = 0.25

@onready var animator = $Body
#@onready var arm_gun = get_node("Arms")
#@onready var armsAnimator = get_node("Arms/Animator")
@onready var arms = get_node("Arms/Animator")
@onready var arm_pivot = $ArmPivot

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#deal with the jump mechanic variables

var jump_time = 0
var is_jumping = false # Whether or not the character is currently in a jump
var jump_hold_time = 0.0 # The amount of time the jump button has been held down


func _ready():
	animator.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_jumping:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
		jump_hold_time = 0.0
	elif Input.is_action_just_released("ui_accept") or jump_hold_time >= MAX_JUMP_TIME:
		is_jumping = false
		
	if is_jumping and Input.is_action_pressed("ui_accept") and jump_hold_time < MAX_JUMP_TIME and velocity.y < 0:
		jump_hold_time += delta
		velocity.y -= JUMP_HOLD_VELOCITY * jump_hold_time
	else:
		is_jumping = false

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
		if velocity.y == 0:
			animator.play("Run")
			arms.play("Run")
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		if velocity.y == 0:
			animator.play("Idle")
			arms.play("Idle")
	
	if velocity.y < 0:
		animator.play("Jump")
		arms.play("Jump")
	elif velocity.y > 0:
		animator.play("Fall")
		arms.play("Fall")

	move_and_slide()

func take_gun(weapon):
	arms.visible = false
	add_child(weapon)
	weapon.global_position = arm_pivot.global_position

func flip(x_axis):
	animator.scale.x = x_axis
	arms.scale.x = x_axis
