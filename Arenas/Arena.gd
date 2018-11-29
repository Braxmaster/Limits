extends Node2D
#using a python naming scheme, since GDscript is a bit like python
#most of the stuff in here is currently dummy code for testing, but should be built to take ssensible input
export var battle_positions_left = [Vector2(30, 140), Vector2(60, 170)]
export var battle_positions_right = [Vector2(170, 140), Vector2(140, 170)]
export var arrow_positions_right = [Vector2(150, 140), Vector2(120, 170)]

var combatatants_left
var combatants_right
var is_player_turn = true
var current_monster_index =0

var has_won = false 


func _ready():
	#load some testing characters
	var dummy_character_scene = load("res://Arenas/Dummy_Character.tscn")
	var avatar_scene = load("res://Characters/Avatar.tscn")
	var avatar = avatar_scene.instance()
	var dummy_character1 = dummy_character_scene.instance()
	var dummy_character2 = dummy_character_scene.instance()
	dummy_character1.set_name("Dummy1")
	dummy_character2.set_name("Dummy2")
	combatatants_left = [avatar]
	place_battle_positions_left(combatatants_left)
	
	var dummy_character3 = dummy_character_scene.instance()
	var dummy_character4 = dummy_character_scene.instance()
	dummy_character3.set_name("Obsessive Blasphemous Presence 1")
	dummy_character4.set_name("Obsessive Blasphemous Presence 2")
	combatants_right = [dummy_character3, dummy_character4]
	place_battle_positions_right(combatants_right)
	$Panel_holder.set_text("Uh oh, " + 
	build_enemy_string_names(combatants_right) + 
	" are looking for trouble! "
	)
	
	$Panel_holder.set_moster_arrow_positions(arrow_positions_right)

func _process(delta):
	pass

	
func _input(event):
	if !event.is_echo():
		if event.is_action_pressed("ui_accept"):
			select()
		if not $Panel_holder.monster_select:
			if event.is_action_pressed("ui_up"):
				$Panel_holder.move_cursor("up")
			elif event.is_action_pressed("ui_down"):
				$Panel_holder.move_cursor("down")
			elif event.is_action_pressed("ui_right"):
				$Panel_holder.move_cursor("right")
			elif event.is_action_pressed("ui_left"):
				$Panel_holder.move_cursor("left")
		else:
			if event.is_action_pressed("ui_up"):
				$Panel_holder.move_monster_arrow("up")
			elif event.is_action_pressed("ui_down"):
				$Panel_holder.move_monster_arrow("down")
			

func select():
	print("Select pressed")
	if has_won:
		exit_battle()
	else:
		if not is_player_turn:
			print("monster  select")
			monster_turn()
		elif $Panel_holder.currentpanel.name == "Panel_text" :
			$Panel_holder.show_menu(["test_attack_1", "test_attack2aaaaaaaaaaaaa"])
		elif $Panel_holder.currentpanel.name == "Menu" :
			$Panel_holder.select()
		else:
			$Panel_holder.select()

#Set background to sprite frames, background is animatedsprite since animated backgrounds would be cool
func set_background(sprite_frames):
	$Background.frames = sprite_frames
	
#At the moment there are no characters to work with, assume the character has  a Sprite node
func place_battle_positions_left(characters_array):
	var number_of_characters = characters_array.size()
	#Should raise an error but this will have to do
	if(number_of_characters < battle_positions_left.size()):
		print("Too many characters in this array for the arena")
	
	for i in range(0, number_of_characters):
		characters_array[i].position = battle_positions_left[i]
		add_child(characters_array[i])
		
	
func place_battle_positions_right(characters_array):
	var number_of_characters = characters_array.size()
	#Should raise an error but this will have to do
	if(number_of_characters < battle_positions_right.size()):
		print("Too many characters in this array for the arena")
	
	for i in range(0, number_of_characters):
		characters_array[i].position = battle_positions_right[i]
		add_child(characters_array[i])
		
func build_enemy_string_names(enemy_array):
	var enemy_string = ""
	for i in range(0, enemy_array.size()):
		if not i == enemy_array.size() -1:
			enemy_string = enemy_string + enemy_array[i].get_name() + ", "
			enemy_string = enemy_string + "and " + enemy_array[i].get_name()
	return enemy_string
	
func enemy_is_attacked(attack, enemy_index, damage_amount):
	$Panel_holder.set_text("You threw out a mighty "+ attack +" at " + combatants_right[enemy_index].name)
	print(combatants_right[enemy_index].name + " takes " + str(damage_amount) + "damage!")
	combatants_right[enemy_index].take_damage(damage_amount)
	print(combatants_right[enemy_index].name + " has " + str(combatants_right[enemy_index].current_HP) + " HP left")
	remove_dead_monsters()
	print("enemy size " + str(combatants_right.empty()))
	if combatants_right.empty():
		print("win??")
		player_wins()
		is_player_turn = true
	else: 
		is_player_turn = false
	
	print("is_player_turn " + str(is_player_turn))

func remove_dead_monsters():
		for monster in combatants_right:
			if monster.is_dead:
				remove_child(monster)
				var index = combatants_right.find(monster)
				combatants_right.erase(monster)			
				$Panel_holder.monster_arrow_positions.erase(arrow_positions_right[index])
				$Panel_holder.currently_selected_monster = 0

func monster_turn():
	combatants_right[current_monster_index].perform_attack()
	current_monster_index += 1
	is_player_turn = current_monster_index > combatants_right.size() - 1
	if is_player_turn:
		current_monster_index = 0
	
	
func enemy_attacks(monster_name, attack_name, attack_damage):
	$Panel_holder.set_text(monster_name + " performs a " + attack_name + " and you take " + str(attack_damage) + "damage!")
	
func player_wins():
	$Panel_holder.set_text("Congratulations you win!")
	has_won = true
	
func player_loses():
	$Panel_holder.set_text("Congratulations you lose!")
	
func exit_battle():
	print("Exit the battle")
