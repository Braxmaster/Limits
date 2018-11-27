extends RichTextLabel

var dialogue
var page = 0
var wait_for_text = 0

func _ready():
	pass

func _process(delta):
	wait_for_text += 1
	var INTERACT = Input.is_action_just_pressed("ui_accept")
	if INTERACT and get_node("../../../Avatar").in_event and 30 < wait_for_text:
		next_page()

func _input(event):
	pass

func _on_Timer_timeout():
	visible_characters += 1

func talk(voice = ["I have nothing to say!"]):
	dialogue = voice
	set_bbcode(dialogue[page])
	set_visible_characters(0)
	show()
	$Timer.start()


func next_page():
	page += 1
	if page < dialogue.size():
		set_bbcode(dialogue[page])
		set_visible_characters(0)
	else:
		set_visible_characters(0)
		page = 0
		$Timer.stop()
		get_node("../../../Avatar").can_move = true
		get_node("../../../Avatar").in_event = false
		print("Removing node!")
		get_node("../").queue_free()