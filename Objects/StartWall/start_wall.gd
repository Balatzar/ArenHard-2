extends StaticBody2D

var stopped = false


func remove():
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	stopped = true
	
