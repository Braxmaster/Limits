extends Panel
var currentpanel
var button_array
var currently_selected_column
var currently_selected_row
var currently_selected_option
#Hardcoded positions for the menu. This is an issue, but it works for now.
var selection_arrow_positions =[[3, 11], [48, 11], [93, 11],
[3, 25], [48, 25], [93, 25], 
[3, 39], [48, 39], [93, 39]]

func _ready():
	#Hide all panels
	$Panel_text.hide()
	$Verticalmenu.hide()
	$Selection_arrow.hide()
	button_array = $Verticalmenu/row1.get_children()
	button_array = button_array + $Verticalmenu/row2.get_children()
	button_array =  button_array + $Verticalmenu/row3.get_children()
	
	currently_selected_option = 0
	currently_selected_row = 0
	currently_selected_column = 0
	
	var tempos = selection_arrow_positions[currently_selected_option]
	$Selection_arrow.position = Vector2(tempos[0], tempos[1])
	print(button_array[0].position)

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
		currentpanel = $Verticalmenu
		modify_menu_buttons(button_string_array)
		$Selection_arrow.show()
		currentpanel.show()
	
func modify_menu_buttons(button_string_array):
	for i in range(0, button_string_array.size()):
		button_array[i].set_text(button_string_array[i])
	for i in range(i + 1, button_array.size()):
		button_array[i].set_text("")

func move_cursor(direction):
	if not currently_selected_row == 2 and direction == "down" :
		currently_selected_row =  currently_selected_row  + 1
		currently_selected_option = currently_selected_option + 3
		
	elif not currently_selected_row == 0 and direction == "up" :
		currently_selected_row = currently_selected_row - 1
		currently_selected_option = currently_selected_option - 3
		
	elif not currently_selected_column == 2 and direction == "right" :
		currently_selected_column = currently_selected_column + 1
		currently_selected_option = currently_selected_option + 1
	elif not currently_selected_column == 0 and direction == "left" :
		currently_selected_column = currently_selected_column + - 1
		currently_selected_option = currently_selected_option + - 1
		
	var tempos = selection_arrow_positions[currently_selected_option]
	$Selection_arrow.position = Vector2(tempos[0], tempos[1])