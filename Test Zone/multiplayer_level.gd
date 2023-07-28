extends Node2D

class_name MultiplayerLevel

var characters := [
	#preload("res://Characters/Tricot1/tricot1.tscn"),
	#preload("res://Characters/Octoput/octoput.tscn")
	preload("res://Characters/Tsitah/tsitah.tscn")
	#preload("res://Characters/Bertaaa/bertaaa.tscn")
]

func _ready():
	if not multiplayer.is_server():
		return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)
	
	for id in multiplayer.get_peers():
		add_player(id)
	
	if not OS.has_feature("dedicated_server"):
		add_player(1)

func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int):
	print("add player, id: " + str(id))
	var character = characters[randi() % characters.size()].instantiate()
	character.player = id
	character.global_position = $Spawn.global_position
	character.name = str(id)
	$Players.add_child(character, true)

func del_player(id: int):
	if not $Players.has_node(str(id)):
		return
	$Players.get_node(str(id)).queue_free()
