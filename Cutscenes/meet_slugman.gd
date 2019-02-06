extends Node2D
var avatar 
var slugspeech = ["Greetings fellow traveller! Let me just test out how far this box can stretch! AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
, "So thats how long, pretty cool, how many characters do you think that was?"]

func _ready():
	avatar = $Your_room_scene_1/Avatar
	slugman_enters()
	
#force avatar to move without player input
#TODO: fix so player cant control the avatar in the cutscene
func _process(delta):
	avatar.in_event = true
	avatar.movement_loop()

#TODO: timer seemse to interfere with dialogue timer? Right now is bugged, dialogue not working
#How to identify: try setting timer value to something different (like 4) and söugman will show more dialogue
func slugman_enters():
	var timer = Timer.new()
	timer.set_wait_time(2)
	timer.connect("timeout",self,"_stop_slugman_start_talking")
	timer.one_shot = true
	add_child(timer)
	timer.start()
	$slugman.move_slugman("left")
	
func _stop_slugman_start_talking():
	$slugman.stop_slugman()
	$slugman.set_slugman_animation_talking()
	$Dialogue.show() 
	$Dialogue/Talker.talk(slugspeech)