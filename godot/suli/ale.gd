extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var focus = "soweli"
onready var kije = $kije
onready var soweli = $soweli
# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	change_focus()

func change_focus():
	if focus == "soweli":
		focus = "kije"
		kije.focus(true)
		soweli.focus(false)
	else:
		focus = "soweli"
		soweli.focus(true)
		kije.focus(false)

	
		
func _input(event):
	if event.is_action_pressed("change_focus"):
		change_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
