extends Node2D

func _ready():
	$Avatar/Camera2D.make_current()
	$Avatar/Camera2D.limit_left = 0
	$Avatar/Camera2D.limit_right = 640
	$Avatar/Camera2D.limit_top = 0
	$Avatar/Camera2D.limit_bottom = 0
