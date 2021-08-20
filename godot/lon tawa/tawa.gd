extends KinematicBody2D


#establish scene name for saving

#keep the raycasts in a group - to fall for later
onready var raycasts = {
	"floor": [$floor1, $floor2, $floor3],
}

#player's current physics numbers
export (int) var speed = 500
export (int) var gravity = 2800

export (float, 0, 1.0) var friction = 0.4
export (float, 0, 1.0) var acceleration = 0.20

export (float, 0, 1.0) var jumpheight = 140
export (float, 0, 1.0) var jumpinc = 0.74
export (float, 0, 1.0) var jgravity = 350

#setting up ground variables
var velocity = Vector2.ZERO
var curforce = jumpheight
var jumping = false


var playerpause = false
var curphy:String

var focused = false


onready var anim = $AnimationTree.get("parameters/playback")
onready var base = get_node("/root/ale")

func _ready():
	#turn on things, set the base
	$"collision box".disabled = false
	$AnimationTree.active = true
	anim.travel("idle")
	#base.connect("finish_load", self, "on_load")
	
func on_load():
	pass
	

func raycast(area):
	for i in raycasts[area]:
		if i.is_colliding():
			return true
	return false
	
	
func focus(on):
	if on == true:
		#set_physics_process(true)
		$RemoteTransform2D.update_position = true
		focused = true
	else:
		#set_physics_process(false)
		$RemoteTransform2D.update_position = false
		anim.travel("idle")
		focused = false
		velocity.x = 0
