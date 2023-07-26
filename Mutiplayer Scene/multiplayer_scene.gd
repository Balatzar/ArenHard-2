extends Node

const PORT = 4433
const Player = preload("res://Gladiator/gladiator.tscn")

func _ready():
	print("ready")
	# You can save bandwidth by disabling server relay and peer notifications.
	multiplayer.server_relay = false
	# Automatically start the server in headless mode.
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_pressed.call_deferred()
	
	var id = ResourceLoader.get_resource_uid(Player.resource_path)
	get_tree().multiplayer.spawn_config(id, MultiplayerAPI.REPLICATION_MODE_SERVER, [&"player_name", &"position"])
	# multiplayer.replicator.sync_config(id, 16, [&"position"])



func _on_connect_pressed():
	# Start as client.
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()

func start_game():
	# Hide the UI and unpause to start the game.
	$UI.hide()


func _on_host_pressed():
	# Start as server.
	print("start")
	OS.alert("start")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()
