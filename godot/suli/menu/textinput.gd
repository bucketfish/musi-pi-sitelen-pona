extends Node2D


# Declare member variables here. Examples:
onready var mod = $Sprite2
onready var back = $"../../CanvasLayer/back"
onready var line = $Control/Control/LineEdit

signal color(val)
signal enter
# Called when the node enters the scene tree for the first time.
const pics = {
	"linja": preload("res://suli/menu/linja.png"),
	"monsi": preload("res://suli/menu/monsi.png"),
}

func _ready():
	visible = false
	back.visible = false
	line.editable = false
	redo_color()
	
func redo_color():
	persistent.set_color(self)
	
func _show(thing):
	visible = true
	back.visible = true
	mod.texture = pics[thing]
	line.editable = true
	line.text = ""
	line.grab_focus()
	var pona = false
	
	while pona == false:
		yield(self, "enter")
		
		if true:
			persistent.nasin["kule"][thing] = line.text
			persistent.reset_color()
			pona = true
		else:
			pass
	
	visible = false
	back.visible = false
	line.editable = false
	emit_signal("color", line.text)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("enter")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
