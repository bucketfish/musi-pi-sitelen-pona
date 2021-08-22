extends Sprite


export var id:String


# Called when the node enters the scene tree for the first time.
func _ready():
	check()
	
func check():
	if id in persistent.sona["jo"]:
		visible = true
	else:
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
