extends Node

var curr_scene

func _ready():
	pass

func change_scene(scene_name):
	print("Changing scene to " + scene_name)
	get_tree().change_scene(scene_name)