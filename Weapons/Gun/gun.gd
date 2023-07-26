extends Area2D

@export var Weapon : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.visibility_layer == 1:
		var weapon = Weapon.instantiate()
		body.take_gun(weapon)
		queue_free()
