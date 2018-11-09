extends Node2D
#using a python naming scheme, since GDscript is a bit like python
var battle_positions_left
var battle_positions_right

func _ready():
	#Put background in the background
	#Testing
	battle_positions_left = [Vector2(30, 140), Vector2(60, 170)]
	battle_positions_right = [Vector2(170, 140), Vector2(140, 170)]
	
	var dummy_character_scene = load("res://Arenas/Dummy_Character.tscn")
	var dummy_character1 = dummy_character_scene.instance()
	var dummy_character2 = dummy_character_scene.instance()
	place_battle_positions_left([dummy_character1, dummy_character2])
	
	var dummy_character3 = dummy_character_scene.instance()
	var dummy_character4 = dummy_character_scene.instance()
	place_battle_positions_right([dummy_character3, dummy_character4])
	

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
