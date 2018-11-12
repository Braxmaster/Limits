extends Panel
var currentpanel
var button_array

func _ready():
	#Hide all panels
	$Panel_text.hide()
	$Verticalmenu.hide()
	button_array = $Verticalmenu/row1.get_children()
	button_array = button_array + $Verticalmenu/row2.get_children()
	button_array =  button_array + $Verticalmenu/row3.get_children()
	print(button_array)

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
		currentpanel.show()
	
func modify_menu_buttons(button_string_array):
	for i in range(0, button_string_array.size()):
		button_array[i].set_text(button_string_array[i])
	for i in range(i + 1, button_array.size()):
		button_array[i].set_text("")
		
		