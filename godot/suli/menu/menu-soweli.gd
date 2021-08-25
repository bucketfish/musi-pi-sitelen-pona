extends "res://lon tawa/tawa.gd"


#establish scene name for saving
export var scene_id = "soweli"

#physics modes with numbers

func _ready():
	base = $".."
	raycasts = {
		"floor": [$floor1, $floor2, $floor3],
	}
	


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
	if Input.is_action_just_released("jump") && !floating:	
		if velocity.y < 0:
			velocity.y += jgravity
		jumping = false
	
	$Label.text = str(velocity.y)
	if Input.is_action_pressed("jump") && !floating:
		if onfloor:
			jumping = true
		
		#jumping
		if jumping:
			#velocity.y = velocity.y - curforce
			velocity.y = clamp(velocity.y - curforce, -600, 10000000)
			curforce = curforce * jumpinc

	
	#reseting values when hitting floor
	if onfloor:
		curforce = jumpheight
		
		
			

	
	#if $dig.is_colliding():
		#$Label.text = str($dig.get_collision_point())
		#$Label.text = str(Vector2(floor($dig.get_collision_point().x / 92), floor($dig.get_collision_point().y / 92)))
	
		
	
		
	#left + right movement
	if Input.is_action_pressed("right"):
		$Sprite.set_flip_h(false)

	elif Input.is_action_pressed("left"):
		$Sprite.set_flip_h(true)
		

	
	#animation
	if jumping || floating:
		anim.travel("idle")
	elif Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		anim.travel("walk")
	else:
		anim.travel("idle")

	
func _physics_process(delta):
	if !(base.state in ["choose", "input"]):
		return
		
	if base.state == "choose":
		get_input(delta)
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta * 70)
		jumping = false


	velocity.y = clamp(velocity.y + gravity * delta, -1500, 1500)
		
	
	var snap = Vector2.DOWN if !jumping else Vector2.ZERO
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.is_in_group("push"):
			col.collider.apply_central_impulse(-col.normal * inertia)
	

