extends StaticBody2D


func remove():
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
