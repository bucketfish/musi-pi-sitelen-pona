extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal nextline

onready var border = $lukin/border
onready var back = $lukin/back
onready var border_toki1 = $"ijo toki/border"
onready var back_toki1 = $"ijo toki/back"
onready var border_toki2 = $"ijo toki2/border"
onready var back_toki2 = $"ijo toki2/back"
onready var toki1 = $"ijo toki/toki"
onready var toki2 = $"ijo toki2/toki"
onready var text = $text
onready var ijo1 = $"ijo toki"
onready var ijo2 = $"ijo toki2"

onready var base = get_node("/root/ale")

onready var lines = preload("lines.gd").new()


const pics = {
	"soweli": preload("res://lon tawa/soweli.png"),
	"akesi": preload("res://lon tawa/akesi.png"),
	"pipi": preload("res://lon tawa/pipi.png"),
	"kala": preload("res://lon tawa/kala.png"),
	"kije": preload("res://lon tawa/kije.png"),
	"waso": preload("res://lon tawa/waso.png"),
	"jan": preload("res://lon tawa/jan.png"),
}
# Called when the node enters the scene tree for the first time.

var showing = false
var current = ""

func _ready():
	persistent.set_color(border)
	persistent.set_color(back)
	persistent.set_color(border_toki1)
	persistent.set_color(back_toki1)
	persistent.set_color(border_toki2)
	persistent.set_color(back_toki2)
	persistent.set_color(toki1)
	persistent.set_color(toki2)
	persistent.set_color(text)
	
	visible = false
	showing = false
	ijo1.visible = false
	ijo2.visible = false
	#show_dialogue("kije_open")
	
func show_dialogue(cur):
	base.state = "dialogue"
	visible = true
	showing = true
	ijo1.visible = false
	ijo2.visible = false
	dialogue_loop(lines.line[cur])
	
	
func dialogue_loop(cur):
	for i in cur:
		match i[0]:
			"s":
				display(i[1], i[2], i[3])
				yield(self, "nextline")
				
		end_turn()
	end()
	
func _input(event):
	if event.is_action_pressed("jump") && showing:
		emit_signal("nextline")

func display(input, chara, pos):
	text.bbcode_text = tr(input)
	if pos == "l":
		ijo1.visible = true
		toki1.texture = pics[chara]
	else:
		ijo2.visible = true
		toki2.texture = pics[chara]
		
func end_turn():
	ijo1.visible = false
	ijo2.visible = false

func end():
	showing = false
	visible = false
	yield(get_tree().create_timer(0.1), "timeout")
	base.state = "game"
