extends Node2D
var avatar 
var slugspeech = ["Greetings fellow traveller! Let me just test out how far this box can stretch! AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
, "So thats how long, pretty cool, how many characters do you think that was?"]

func _ready():
	avatar = $Your_room_scene_1/Avatar
	#Need player character that can move, but that doesn't control, best choice is separating controls from character.
	avatar.can_move = false
	slugman_enters()
	
	
func _process(delta):
	move_down_to_slugman()
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		$Dialogue/Talker.next_page()

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
	avatar.movedir.y = 0
	$Dialogue.show() 
	$Dialogue/Talker.talk(slugspeech)

func move_down_to_slugman():
	if abs(avatar.position.y - $slugman.position.y) > 10:
		avatar.movedir.y = 1
	else:
		avatar.movedir.y = 0
		avatar.get_node("Sprite").frame = 3
	