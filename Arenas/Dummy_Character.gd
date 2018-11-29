extends Node2D
var attack_list = ["Spooky attack"]
#Should be extended to cause other effects
var attack_damage = {attack_list[0]: 20}
var max_HP = 30
var current_HP = max_HP
var is_dead = false

func _ready():
	pass
	
func take_damage(damage):
	current_HP -= damage
	is_dead = current_HP < 0

#Only one attack at the moment, make some rudiemntary A.I later.
func perform_attack():
	print(name + " attacks")
	get_parent().enemy_attacks(name, attack_list[0], attack_damage[attack_list[0]])
