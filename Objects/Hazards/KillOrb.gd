extends Node2D

@onready var animator = $Animator
@export var damage := 100
# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play('Idle')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#


func _on_area_2d_body_entered(body):
	if body.is_in_group("Players"):
		body.hurt(damage)
