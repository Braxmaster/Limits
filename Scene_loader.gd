extends Node

var curr_scene

func _ready():
	pass

func remove_scene(scene_name):
	print("Removing scene: " + scene_name)
	var scene_to_remove = get_node(scene_name)
	remove_child(scene_to_remove)

func add_scene(scene_name):
	print("Adding scene: " + scene_name)
	var next_level_resource = load(scene_name)
	var next_level = next_level_resource.instance()
	add_child(next_level)
	
#	get_tree().change_scene(scene_name)