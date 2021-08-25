extends "res://tomo/tomo.gd"


onready var line = $CanvasLayer2/input/Control/Control/LineEdit
onready var backy = $CanvasLayer/back
onready var input = $CanvasLayer2/input


var state = "choose"

func _ready():
	redo_color()
	
func redo_color():
	persistent.set_color(self)
	persistent.set_color(backy)
	#persistent.set_color(line)



func choose(thing, group):
	if thing.ijo_id in $anim.get_animation_list() && thing.selected == true:
		$anim.play(thing.ijo_id)
	elif thing.ijo_id in $anim.get_animation_list() && thing.selected == false:
		$anim.play_backwards(thing.ijo_id)
	
	propagate_call("ijo_select", [thing.ijo_id, group, thing.selected])
	
	if group == "nasinkule" && thing.selected == true:
		input._show(thing.ijo_id)
		state = "input"
		var newcol = yield(input, "color")
		state = "choose"
		thing.selected = false
		choose(thing, group)
		
