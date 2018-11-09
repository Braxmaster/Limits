extends Node2D
#using a python naming scheme, since GDscript is a bit like python
var battle_positions_left
var battle_positions_right

func _ready():
	battle_positions_left = [Vector2(30, 30), Vector2(60, 60)]
	battle_positions_left = [Vector2(170, 30), Vector2(140, 60)]
	pass
	

#Set background to sprite frames, background is animatedsprite since animated backgrounds would be cool
func set_background(sprite_frames):
	$Background.frames = sprite_frames
	
#At the moment there are no characters to work with, asume the character has  a Sprite node
func place_battle_positions_left(characters_array):
	number_of_characters = characters_array.size()
	#Should raise an error but this will have to do
	if(number_of_characters < battle_positions_left.size()):
		print("Too many characters in this array for the arena")
	
	for i in range(0, number_of_characters):
		pass
	
func place_battle_positions_right(characters_array):
	pass
