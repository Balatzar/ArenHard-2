extends MultiplayerLevel


func _on_start_pressed():
	if multiplayer.is_server() && $StartWall && is_instance_valid($StartWall):
		$StartWall.remove()
