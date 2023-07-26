extends Area2D

@export var speed = 750

func _init():
	top_level = true

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Players"):
		body.queue_free()
	queue_free()
