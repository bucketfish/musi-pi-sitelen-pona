extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var collisions = [$sike, $sike2, $sike3, $sike4, $leko, $leko2, $leko3, $leko4, $big]

# Called when the node enters the scene tree for the first time.
func _ready():
	check()
	
func check():
	if "leko" in persistent.sona["jo"]:
		visible = true
		for i in collisions:
			i.disabled = false
		
	else:
		visible = false
		for i in collisions:
			i.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
