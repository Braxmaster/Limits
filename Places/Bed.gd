extends Node2D

func _ready():
	pass

func _process(delta):
	pass

func do():
	print("Bed is doing something!")
	var next_level_resource = load("res://Tools/Dialogue.tscn")
	var next_level = next_level_resource.instance()
	get_node("../UI").add_child(next_level)
	get_node("../UI/Dialogue/RichTextLabel").talk()
#	get_node("../UI/Dialogue/RichTextLabel").talk()