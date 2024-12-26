extends Node

@export var character_scene: PackedScene

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	print_helper("player with authority %s spawned" %get_multiplayer_authority())

func _ready():
	if is_multiplayer_authority():
		$PlayerMenu.show()

func _on_spawn_pressed():
	$PlayerSpawnRoot.add_child(character_scene.instantiate(), true)
	$PlayerMenu.hide()

func print_helper(message):
	print(get_node("/root/Lobby").multiplayer.get_unique_id(), ": ", message)
