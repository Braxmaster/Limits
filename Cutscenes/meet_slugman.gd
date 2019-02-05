extends Node2D
var avatar 
func _ready():
	avatar = $Your_room_scene_1/Avatar
	slugman_enters()
	avatar.movedir.y = 1
	
#force avatar to move without player input
func _process(delta):
	avatar.can_move = false
	avatar.movement_loop()

func slugman_enters():
	var timer = Timer.new()
	timer.set_wait_time(2)
	timer.connect("timeout",self,"_stop_slugman_start_talking") 
	add_child(timer)
	timer.start()
	$slugman.move_slugman("left")
	
func _stop_slugman_start_talking():
	$slugman.stop_slugman()
	$slugman.set_slugman_animation_talking() 