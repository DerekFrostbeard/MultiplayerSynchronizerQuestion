extends Node

var value = 0

func _enter_tree():
	set_multiplayer_authority(get_parent().get_multiplayer_authority())
	print_helper("character with authority %s spawned" %get_multiplayer_authority())

func _ready():
	if is_multiplayer_authority():
		$CharacterMenu.show()

func _on_print_value_pressed():
	print_helper(value)
	print_value.rpc()

@rpc()
func print_value():
	print_helper(value)

func _on_increment_pressed():
	value += 1

func _on_kill_pressed():
	get_parent().get_parent().get_node("PlayerMenu").show()
	queue_free()

func _exit_tree():
	print_helper("character freed")

func print_helper(message):
	print(get_node("/root/Lobby").multiplayer.get_unique_id(), ": ", message)
