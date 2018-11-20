extends Node2D

func _ready():
	var player = $Avatar
	$Avatar/Camera2D.clear_current()
#	$Avatar/Camera2D.limit_top = 0
#	$Avatar/Camera2D.limit_bottom = 0
#	$Avatar/Camera2D.limit_left = 0
#	$Avatar/Camera2D.limit_right = 320
	var Things = get_tree().get_nodes_in_group("Things")
	for i in Things:
		print("Connecting " + i.name + " with " + player.name)
		i.get_node("Area2D").connect("body_entered", player, "_on_area2D_body_enter", [i])
		i.get_node("Area2D").connect("body_exited", player, "_on_area2D_body_exit", [i])

func _process(delta):
	$Avatar.position.x = clamp($Avatar.position.x, 30, 290)
	$Avatar.position.y = clamp($Avatar.position.y,65 ,204)
