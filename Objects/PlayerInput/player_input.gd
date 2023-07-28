extends MultiplayerSynchronizer

@export var jumping := false
@export var just_jumped := false
@export var just_shooted := false

@export var direction := 0
@export var mouse_pos := Vector2()
@export var is_shooting := false

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


@rpc("call_local")
func jump():
	jumping = true

@rpc("call_local")
func has_jumped():
	just_jumped = true

@rpc("call_local")
func shoot():
	just_shooted = true
	
@rpc("call_local")
func start_shooting():
	is_shooting = true
	
@rpc("call_local")
func stop_shooting():
	is_shooting = false
	
func _process(delta):
	direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_accept"):
		jump.rpc()
	if Input.is_action_just_released("ui_accept"):
		has_jumped.rpc()
	if Input.is_action_just_pressed("shoot"):
		shoot.rpc()
	mouse_pos = $Space.get_global_mouse_position()
	
	if Input.is_action_pressed("shoot"):
		start_shooting.rpc()
	if Input.is_action_just_released("shoot"):
		stop_shooting.rpc()
	
