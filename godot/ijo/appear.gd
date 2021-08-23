extends Sprite


export var id:String


# Called when the node enters the scene tree for the first time.
func _ready():
	init_jo()
	
func init_jo():
	if id in persistent.sona["jo"]:
		visible = true
	else:
		visible = false

	
func check(thing):
	if id == thing:
		visible = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
