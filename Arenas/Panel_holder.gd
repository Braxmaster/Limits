extends Panel
var currentpanel
var button_array
var currently_selected_column
var currently_selected_row
var currently_selected_option
#Hard coded positions, not very good. this is whu the labels need to be 20 characters.
var selection_arrow_positions = [[4, 11], [79, 11], 
[4, 25], [79, 25], 
[4, 39], [79, 39]]


func _ready():
	#Hide all panels
	$Panel_text.hide()
	$Menu.hide()
	$Selection_arrow.hide()
	button_array = $Menu.get_children()
	
	currently_selected_option = 0
	currently_selected_row = 0
	currently_selected_column = 0
	
	var tempos = selection_arrow_positions[currently_selected_option]
	$Selection_arrow.position = Vector2(tempos[0], tempos[1])
	#print(button_array[0].position)

func set_text(text):
	#This doesnt seem very elegant but it works
	if not currentpanel == null:
		currentpanel.hide()
	if currentpanel == null or not currentpanel.name == "Panel_text":
		currentpanel = $Panel_text
		currentpanel.clear()
		currentpanel.add_text(text)
		currentpanel.show()
		
func show_menu(button_string_array):
	if not currentpanel == null:
		currentpanel.hide()
	if currentpanel == null or not currentpanel.name == "Verticalmenu":
		currentpanel = $Menu
		modify_menu_buttons(button_string_array)
		$Selection_arrow.show()
		currentpanel.show()
	
func modify_menu_buttons(button_string_array):
	for i in range(0, button_string_array.size()):
		edit_label(button_array[i], button_string_array[i])
	for i in range(i + 1, button_array.size()):
		button_array[i].set_text("")
		
func edit_label(label, text):
	#Menu isn't very well coded, thus strings must be of length 20
	if text.length() > 20:
		text = text.substr(0, 17)
		text = text + "..."
	elif text.length() < 20:
		for i in range(text.length(), 24):
			text = text + " "
	print(text + " length: " + str(text.length()))
	label.set_text(text)


func move_cursor(direction):
	if not currently_selected_row == 2 and direction == "down" :
		currently_selected_row =  currently_selected_row  + 1
		currently_selected_option = currently_selected_option + 2
		
	elif not currently_selected_row == 0 and direction == "up" :
		currently_selected_row = currently_selected_row - 1
		currently_selected_option = currently_selected_option - 2
		
	elif not currently_selected_column == 1 and direction == "right" :
		currently_selected_column = currently_selected_column + 1
		currently_selected_option = currently_selected_option + 1
	elif not currently_selected_column == 0 and direction == "left" :
		currently_selected_column = currently_selected_column - 1
		currently_selected_option = currently_selected_option - 1
		
	var tempos = selection_arrow_positions[currently_selected_option]
	$Selection_arrow.position = Vector2(tempos[0], tempos[1])