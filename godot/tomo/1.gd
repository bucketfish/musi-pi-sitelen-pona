extends "res://tomo/tomo.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if !("lon" in persistent.sona["jo"]):
		$sep/Sprite.visible = true
		$"../tawa/soweli".floating = true
	else:
		$sep/Sprite.visible = false
		$"../tawa/soweli".floating = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ijo_jo(id):
	if id == "lon":
		$cutscene.play("lon")
