extends Area2D

class_name Weapon

@export var weapon_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.visibility_layer == 1:
		body.take_gun(weapon_name)
		queue_free()
