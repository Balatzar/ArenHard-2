extends CharacterBody2D

class_name Character

@export var SPEED := 500.0
@export var JUMP_VELOCITY := -400
@export var JUMP_HOLD_VELOCITY := 40.0 # Additional jump velocity when holding the button
@export var MAX_JUMP_TIME := 0.50
@export_range(0.0, 1.0) var FRICTION = 0.1
@export_range(0.0 , 1.0) var ACCELERATION = 0.25
@export var Arms : PackedScene
@export var characterName : String
@export var max_health := 100

@export var player := 1 :
	set(id):
		player = id

@onready var animator = $Body
@onready var health = max_health
@onready var input = $PlayerInput

func _enter_tree():
	$PlayerInput.set_multiplayer_authority(str(name).to_int())

var arms

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#deal with the jump mechanic variables

var jump_time = 0
var is_jumping = false # Whether or not the character is currently in a jump
var jump_hold_time = 0.0 # The amount of time the jump button has been held down


func _ready():
	print(input)
	animator.play("Idle")
	print("instance arms")
	arms = Arms.instantiate()
	print("arms instanciated")
	add_child(arms)
	print("arms added")
	print("player ID : " + str(player))
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health
	
	print("multiplayer.get_unique_id()")
	print(multiplayer.get_unique_id())

	if player == multiplayer.get_unique_id():
		$Camera2D.enabled = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if input.jumping and is_on_floor() and not is_jumping:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
		jump_hold_time = 0.0
	elif input.just_jumped or jump_hold_time >= MAX_JUMP_TIME:
		is_jumping = false
		
	if is_jumping and input.jumping and jump_hold_time < MAX_JUMP_TIME and velocity.y < 0:
		jump_hold_time += delta
		velocity.y -= JUMP_HOLD_VELOCITY * jump_hold_time
	else:
		is_jumping = false
	
	input.jumping = false
	input.just_jumped = false

	if input.direction:
		velocity.x = lerp(velocity.x, input.direction * SPEED, ACCELERATION)
		if velocity.y == 0:
			animator.play("Run")
			if is_instance_valid(arms):
				arms.animator.play("Run")
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		if velocity.y == 0:
			animator.play("Idle")
			if is_instance_valid(arms):
				arms.animator.play("Idle")
	
	if velocity.y < 0:
		animator.play("Jump")
		if is_instance_valid(arms):
			arms.animator.play("Jump")
	elif velocity.y > 0:
		animator.play("Fall")
		if is_instance_valid(arms):
			arms.animator.play("Fall")

	move_and_slide()
	

func take_gun(weapon: String):
	var res := "res://Characters/" + characterName + "/" + characterName + "Arm" + weapon.capitalize().replace(" ", "") + "/" + characterName.to_lower() + "_arm_" + weapon + ".tscn"
	print(res)
	for node in get_children():
		if node.has_method("kind") and node.kind() == "weapon":
			node.call_deferred("queue_free")
	
	var weapon_arms = load(res).instantiate()
	add_child(weapon_arms)
	weapon_arms.global_position = $ArmPivot.global_position

func flip(x_axis):
	animator.scale.x = x_axis
	if is_instance_valid(arms):
		arms.scale.x = x_axis

func hurt(damage: int):
	velocity.y = -300
	velocity.x = 200
	set_health(health - damage)
	if health <= 0:
		die()

func set_health(new_health):
	health = clamp(new_health, 0, max_health)
	$HealthBar.value = health

func die():
	global_position = get_parent().get_parent().get_node("Spawn").global_position
	set_health(max_health)
