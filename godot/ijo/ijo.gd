extends Area2D


export var ijo_id:String
export var func_call = ""

onready var base = get_node("/root/ale")
onready var dialogue = get_node("/root/ale/toki/dialogue")

var funcs = {
}

signal jo(id)
# Called when the node enters the scene tree for the first time.
func _ready():
	init_jo()
	funcs = {
		"kije": [funcref(dialogue, "show_dialogue"), "kije_open"]
	}

	
func init_jo():
	if ijo_id in persistent.sona["jo"]:
		queue_free()	
		
func check(thing):
	if ijo_id == thing:
		queue_free()
		
func _on_body_entered(body):
	if body.is_in_group("lon tawa"):
		emit_signal("jo", ijo_id)
		if ijo_id in funcs:
			funcs[ijo_id][0].call_func(funcs[ijo_id][1])
		persistent.add_jo(ijo_id)
		queue_free()
