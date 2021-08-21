extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var focus = "soweli"
var kije_climbing = false
var kije = preload("res://lon tawa/kije.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	change_focus()

func change_focus(thing=""):
	if (thing == "" && focus == "soweli") || thing == "kije":

		if kije_climbing:
			var new = kije.instance()
			new.position = $soweli.position
			new.position.y -= 48
			
			add_child(new)
			$soweli.kije_climb(false)
			kije_climbing = false
			
		focus = "kije"
		$soweli.focus(false)
		$kije.focus(true)
		
	else:
		focus = "soweli"
		$soweli.focus(true)
		if !kije_climbing:
			$kije.focus(false)

	
		
func _input(event):
	if event.is_action_pressed("change_focus"):
		change_focus()

func kije_climb():
	change_focus()
	$soweli.kije_climb(true)
	kije_climbing = true
	
