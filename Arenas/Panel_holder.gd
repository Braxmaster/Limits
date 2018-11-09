extends Node2D
var currentpanel

func _ready():
	pass

func set_text(text):
	if currentpanel == null or not currentpanel.name == "Text_panel":
		currentpanel = $Text_panel
		var richtextlabel = $Text_panel.get_node("Panel_text")
		richtextlabel.clear()
		richtextlabel.add_text(text)
	