extends Node

const SERVER_IP = "127.0.0.1" # localhost
const SERVER_PORT = 9999
var peer = ENetMultiplayerPeer.new()

@export var player_scene: PackedScene

func _on_host_pressed():
	print_helper("hosting")
	peer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)
	$LobbyMenu.hide()

func _peer_connected(id: int):
	print_helper("client %s connected" % id)

func _peer_disconnected(id: int):
	print_helper("client %s disconnected" % id)

func _on_join_pressed():
	print_helper("joining")
	peer.create_client(SERVER_IP, SERVER_PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.connected_to_server.connect(_connected_to_server)
	multiplayer.connection_failed.connect(_connection_failed)
	multiplayer.server_disconnected.connect(_server_disconnected)
	$LobbyMenu.hide()

func _connected_to_server():
	print_helper("connected to server")
	spawn_player.rpc_id(1)

func _connection_failed():
	print_helper("connection failed")
	
func _server_disconnected():
	print_helper("server disconnected")

@rpc("any_peer", "reliable")
func spawn_player():
	var player = player_scene.instantiate()
	player.name = str(multiplayer.get_remote_sender_id())
	$PlayerSpawnRoot.add_child(player)

func print_helper(message):
	print(get_node("/root/Lobby").multiplayer.get_unique_id(), ": ", message)
