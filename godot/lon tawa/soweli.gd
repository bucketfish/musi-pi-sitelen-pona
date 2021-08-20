extends KinematicBody2D


#establish scene name for saving
export var scene_id = "soweli"

#physics modes with numbers
var physics = {
	"air": {
		"speed": 700,
		"gravity": 2800,
		"friction": 0.4,
		"acceleration": 0.20,
		"jumpheight": 240,
		"jumpinc": 0.74,
		"jgravity": 550
	}
}


#keep the raycasts in a group - to fall for later
onready var raycasts = {
	"floor": [$floor1, $floor2, $floor3],
}

#player's current physics numbers
export (int) var speed = 800
export (int) var gravity = 3000

export (float, 0, 1.0) var friction = 0.4
export (float, 0, 1.0) var acceleration = 0.20

export (float, 0, 1.0) var jumpheight = 250
export (float, 0, 1.0) var jumpinc = 0.79
export (float, 0, 1.0) var jgravity = 600

#setting up ground variables
var velocity = Vector2.ZERO
var curforce = jumpheight
var jumping = false


var playerpause = false
var curphy:String

#onready var base = get_node("/root/game")

func _ready():
	#turn on things, set the base
	change_physics("air")
	$"collision box".disabled = false
	#base.connect("finish_load", self, "on_load")
	
func on_load():
	pass

func get_input(delta):
		
	#settle these variables first
	var onfloor = raycast("floor")
	
	
	#direction of player
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	
	#sideways speed, and/or friction
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration * delta * 70)
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta * 70)

	#apply gravity when finished jumping
	if Input.is_action_just_released("jump"):	
		if velocity.y < 0:
			velocity.y += jgravity
		jumping = false
			
	#normal jumping
	
	$Label.text = str(onfloor)
	if Input.is_action_pressed("jump"):
		if onfloor:
			jumping = true
		
		#jumping
		if jumping:
			velocity.y = velocity.y - curforce
			#velocity.y = clamp(velocity.y - curforce, -800, 10000000)
			curforce = curforce * jumpinc
			$Label.text = str(curforce) + " " + str(jumpinc) + " " + str(curforce*jumpinc)
		
	
	
	#reseting values when hitting floor
	if onfloor:
		curforce = jumpheight
		
	#left + right movement
	if Input.is_action_pressed("right"):
		$Sprite.set_flip_h(false)

	elif Input.is_action_pressed("left"):
		$Sprite.set_flip_h(true)
		
	#gravity
	velocity.y = clamp(velocity.y + gravity * delta, -1500, 1500)
	
		
	#animation
	

func _physics_process(delta):
	get_input(delta)
	var snap = Vector2.DOWN if !jumping else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP )
	
	
func change_physics(new):
	curphy = new
	for i in physics[new].keys():
		set(i, physics[new][i])


func raycast(area):
	for i in raycasts[area]:
		if i.is_colliding():
			return true
	return false
	

		
