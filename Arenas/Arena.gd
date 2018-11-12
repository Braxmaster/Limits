extends Node2D
#using a python naming scheme, since GDscript is a bit like python
export var battle_positions_left = [Vector2(30, 140), Vector2(60, 170)]
export var battle_positions_right = [Vector2(170, 140), Vector2(140, 170)]



func _ready():
	#load some testing characters
	var dummy_character_scene = load("res://Arenas/Dummy_Character.tscn")
	var avatar_scene = load("res://Characters/Avatar.tscn")
	var avatar = avatar_scene.instance()
	var dummy_character1 = dummy_character_scene.instance()
	var dummy_character2 = dummy_character_scene.instance()
	dummy_character1.set_name("Dummy1")
	dummy_character2.set_name("Dummy2")
	place_battle_positions_left([avatar, dummy_character2])
	
	var dummy_character3 = dummy_character_scene.instance()
	var dummy_character4 = dummy_character_scene.instance()
	dummy_character3.set_name("Obsessive Blasphemous Presence 1")
	dummy_character4.set_name("Obsessive Blasphemous Presence 2")
	place_battle_positions_right([dummy_character3, dummy_character4])
	$Panel_holder.set_text("Uh oh, " + 
	build_enemy_string_names([dummy_character3, dummy_character4]) + 
	" are looking for trouble! "
	)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		select()

func select():
	if $Panel_holder.currentpanel.name == "Panel_text" :
		$Panel_holder.show_menu(["test_attack_1", "test_attack2"])
		print("enter")

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
		else:
			enemy_string = enemy_string + "and " + enemy_array[i].get_name()
	return enemy_string
