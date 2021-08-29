extends "res://tomo/tomo.gd"


onready var line = $CanvasLayer2/input/Control/Control/LineEdit
onready var backy = $CanvasLayer/back
onready var input = $CanvasLayer2/input
onready var background = $CanvasLayer3/ColorRect
onready var soweli = $"menu-soweli"

onready var game = get_node("/root/ale")


var state = "choose"



func _ready():
	redo_color()
	_hide()
	
func redo_color():
	persistent.set_color(self)
	persistent.set_color(backy)
	persistent.set_color(background)
	#persistent.set_color(line)

func _show():
	#print("AAAA")
	visible = true
	background.visible = true
	soweli.position.x = 150.085
	soweli.position.y = 483.565
	
func _hide():
	visible = false
	background.visible = false

func choose(thing, group):
	if thing.ijo_id in $anim.get_animation_list() && thing.selected == true:
		$anim.play(thing.ijo_id)
		
	elif thing.ijo_id in $anim.get_animation_list() && thing.selected == false:
		$anim.play_backwards(thing.ijo_id)
		persistent._save("nasin")
	
	propagate_call("ijo_select", [thing.ijo_id, group, thing.selected])
	
	if group == "nasinkule" && thing.selected == true:
		input._show(thing.ijo_id)
		state = "input"
		yield(input, "end")
		state = "choose"
		thing.selected = false
		choose(thing, group)
		
	elif thing.ijo_id == "musi" && group == "main":
		_unpause()
		
func _input(event):
	
	if Input.is_action_just_pressed("pause") && !game.pause:
		_pause()

	elif Input.is_action_just_pressed("pause") && game.pause && state=="choose":
		_unpause()

		
	elif Input.is_action_just_pressed("pause") && game.pause && state=="input":
		input._close()
		
		
	if Input.is_action_just_pressed("ui_accept") && game.pause && state=="input":
		input.emit_signal("enter")
		

func _pause():
	game.pause = true
	_show()
	
func _unpause():
	game.pause = false
	_hide()
	game.emit_signal("unpause")
	game.change_focus(game.focus)
