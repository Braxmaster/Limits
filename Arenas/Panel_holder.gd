extends Panel
#Save current panel for checking in the arena
var currentpanel
#What labels we currently have
var button_array
#These are for selecting
var currently_selected_column
var currently_selected_row
var currently_selected_option
#Should be set when loading in the monsters
var monster_arrow_positions = []
#Enable the arrow to go to all positions by standard
var not_disabled_options = 6
#Determine if we are in monster select mode or not
var monster_select = false
#currently selected monster
var currently_selected_monster = 0
#Hard coded arrow positions, not very good. this is why the labels need to be 20 characters.
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
		var tempos = selection_arrow_positions[currently_selected_option]
		$Selection_arrow.position = Vector2(tempos[0], tempos[1])
		$Selection_arrow.show()
		currentpanel.show()
	
func modify_menu_buttons(button_string_array):
	for i in range(0, button_string_array.size()):
		not_disabled_options  = i
		edit_label(button_array[i], button_string_array[i])
	for i in range(i + 1, button_array.size()):
		button_array[i].set_text("")
		
func edit_label(label, text):
	#Menu isn't very well coded, thus strings must be of length 20
	if text.length() > 20:
		text = text.substr(0, 17)
		text = text + "..."
	elif text.length() < 20:
		#Because spaces are smaller than regular characters, string needs to be padded to 24 in length
		for i in range(text.length(), 24):
			text = text + " "
	label.set_text(text)
	
func select():
	if not monster_select:
		monster_select = true
		$Selection_arrow.position = monster_arrow_positions[currently_selected_monster]
	else:
		attack_currently_selected_monster()

#Positions should be a bunch of vec2d
func set_moster_arrow_positions(positions):
	monster_arrow_positions = positions
	
func move_monster_arrow(direction):
	if direction == "up":
		currently_selected_monster = currently_selected_monster - 1
		if currently_selected_monster < 0:
			currently_selected_monster = monster_arrow_positions.size() - 1
	if direction == "down":
		currently_selected_monster = currently_selected_monster + 1
		if currently_selected_monster > monster_arrow_positions.size() - 1:
			currently_selected_monster = 0
	print(str(currently_selected_monster))
	$Selection_arrow.position = monster_arrow_positions[currently_selected_monster]
	
func attack_currently_selected_monster():
	$Selection_arrow.hide()
	#Need to remove potential whitespaces at the end
	var attacktext = button_array[currently_selected_option].text.strip_edges(false, true)
	get_parent().enemy_is_attacked(attacktext, currently_selected_monster, 20)
	monster_select = false

func move_cursor(direction):
	if not currently_selected_row == 2 and direction == "down" :
		currently_selected_row =  currently_selected_row  + 1
		currently_selected_option = currently_selected_option + 2
		#revert if we access an unselected menu slot
		if (currently_selected_option > not_disabled_options):
			currently_selected_row =  currently_selected_row  - 1
			currently_selected_option = currently_selected_option - 2
		
	elif not currently_selected_row == 0 and direction == "up" :
		currently_selected_row = currently_selected_row - 1
		currently_selected_option = currently_selected_option - 2
		#revert if we access an unselected menu slot
		if (currently_selected_option > not_disabled_options):
			currently_selected_row =  currently_selected_row  + 1
			currently_selected_option = currently_selected_option + 2
		
	elif not currently_selected_column == 1 and direction == "right" :
		currently_selected_column = currently_selected_column + 1
		currently_selected_option = currently_selected_option + 1
		#revert if we access an unselected menu slot
		if (currently_selected_option > not_disabled_options):
			currently_selected_row =  currently_selected_row  - 1
			currently_selected_option = currently_selected_option - 2
	elif not currently_selected_column == 0 and direction == "left" :
		currently_selected_column = currently_selected_column - 1
		currently_selected_option = currently_selected_option - 1
		#revert if we access an unselected menu slot
		if (currently_selected_option > not_disabled_options):
			currently_selected_row =  currently_selected_row  + 1
			currently_selected_option = currently_selected_option + 2
		
	var tempos = selection_arrow_positions[currently_selected_option]
	$Selection_arrow.position = Vector2(tempos[0], tempos[1])