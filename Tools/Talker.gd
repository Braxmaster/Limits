extends RichTextLabel

var dialogue
var page = 0
var wait_for_text = 0
var battle = false

func _ready():
	pass

func _on_Timer_timeout():
	visible_characters += 1

func talk(voice):
	dialogue = voice
	set_bbcode(dialogue[page])
	set_visible_characters(0)
	show()
	$Timer.start()

func fast_forward():
	visible_characters = 100

func next_page():
	if visible_characters < len(dialogue[page]):
		fast_forward()
	else:
		page += 1
		if page < dialogue.size():
			set_bbcode(dialogue[page])
			set_visible_characters(0)
		else:
			if battle == false:
				set_visible_characters(0)
				page = 0
				$Timer.stop()
				get_node("../../../Avatar").can_move = true
				get_node("../../../Avatar").in_event = false
				print("Removing node!")
				get_node("../").queue_free()
			if battle == true:
				set_visible_characters(0)
				page = 0
				get_node("../").queue_free()