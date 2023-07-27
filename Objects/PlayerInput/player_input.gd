extends MultiplayerSynchronizer

@export var jumping := false
@export var just_jumped := false

@export var direction := 0

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


@rpc("call_local")
func jump():
	jumping = true

@rpc("call_local")
func has_jumped():
	just_jumped = true

func _process(delta):
	direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_accept"):
		jump.rpc()
	if Input.is_action_just_released("ui_accept"):
		has_jumped.rpc()
