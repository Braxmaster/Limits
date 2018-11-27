extends Node2D

var voice = ["Oh hi there! Whats, up? I am a talking bed! Dont judge!", "I know what you do in the dead of night!"]

func _ready():
	pass

func _process(delta):
	pass

func do():
	var diag_system_res = load("res://Tools/Dialogue.tscn")
	var diag_system = diag_system_res.instance()
	get_node("../UI").add_child(diag_system)
	get_node("../UI/Dialogue/Talker").talk(voice)