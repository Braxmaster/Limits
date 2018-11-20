extends RichTextLabel

var dialogue = ["Oh hi there!", "Whats, up?"]
var page = 0
var wait_for_text = 0

func _ready():
	set_bbcode(dialogue[page])
	set_visible_characters(0)
	show()

func _process(delta):
	print(page)
	wait_for_text += 1
	var INTERACT = Input.is_action_just_pressed("ui_accept")
	if INTERACT and get_node("../../../Avatar").in_event and 30 < wait_for_text:
		next_page()

func _input(event):
#	if event is InputEventKey and get_node("../../../Avatar").in_event:
#		if event.pressed and event.scancode == 16777221 and not event.echo:
#			print("Do stuff")
#			next_page()
	pass

func _on_Timer_timeout():
	visible_characters += 1

func talk():
	print("Start talking!")
	print(dialogue[page])
	$Timer.start()


func next_page():
	page += 1
	if page < dialogue.size():
		set_bbcode(dialogue[page])
		set_visible_characters(0)
		print("Next page!")
		print(dialogue[page])
	else:
		set_visible_characters(0)
		page = 0
		$Timer.stop()
		get_node("../../../Avatar").can_move = true
		get_node("../../../Avatar").in_event = false
		print("Removing node!")
		get_node("../").queue_free()