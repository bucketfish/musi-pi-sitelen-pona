extends Node

var sona = {
	"jo": ["nena"],
	"supa": "",
}

var nasin = {
	"kule":{
		"linja": "#add8ff",
		"monsi": "#454545"
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if not File.new().file_exists("user://jo.lipu"):
		_start()
	else:
		_load()
		
	if not File.new().file_exists("user://nasin.lipu"):
		_start()
	else:
		_load()
		
	VisualServer.set_default_clear_color(nasin["kule"]["monsi"])
	

func set_color(node):
	if node.is_in_group("color"):
		node.modulate = nasin["kule"]["linja"]
	elif node.is_in_group("color-inv"):
		node.modulate = nasin["kule"]["monsi"]


func _save():
	var saves = File.new()
	saves.open("user://jo.lipu", File.WRITE)

	saves.store_line(to_json(sona))
	
	saves.close()
	emit_signal("finish_save")
	
func _load():
	var save_game = File.new()
	if not save_game.file_exists("user://jo.lipu"):
		return # Error! We don't have a save to load.

	save_game.open("user://jo.lipu", File.READ)

	# Get the saved dictionary from the next line in the save file
	sona = parse_json(save_game.get_line())

	save_game.close()
	emit_signal("finish_load")

func _start():
	pass

func add_jo(thing):
	sona["jo"].append(thing)
	get_node("/root/ale").propagate_call("check")
		
