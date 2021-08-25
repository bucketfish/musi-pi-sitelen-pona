extends "res://lon tawa/tawa.gd"


#establish scene name for saving
export var scene_id = "soweli"

#physics modes with numbers

func _ready():
	raycasts = {
		"floor": [$floor1, $floor2, $floor3],
	}
	kije_climb(false)
	

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
		
		
			

		
	if Input.is_action_pressed("down"):
		$dig.rotation_degrees = 90
		
	elif Input.is_action_pressed("up"):
		$dig.rotation_degrees = 270
	
	elif Input.is_action_pressed("right"):
		$dig.rotation_degrees = 0
		
	elif Input.is_action_pressed("left"):
		$dig.rotation_degrees = 180
	
	#if $dig.is_colliding():
		#$Label.text = str($dig.get_collision_point())
		#$Label.text = str(Vector2(floor($dig.get_collision_point().x / 92), floor($dig.get_collision_point().y / 92)))
		
	if Input.is_action_just_pressed("ability"):
		if $dig.is_colliding():
			if $dig.get_collider().is_in_group("kenpakala"):
				var loc = $dig.get_collision_point()
				if $dig.rotation_degrees == 180 || $dig.rotation_degrees == 270:
					loc.x -= 1
					loc.y -= 1
				
				loc.x = floor(loc.x/ 96)
				loc.y = floor(loc.y / 96)

				$"../tomo/ma".set_cellv(loc, -1)
		
	
		
	#left + right movement
	if Input.is_action_pressed("right"):
		$Sprite.set_flip_h(false)
		$Sprite/kije.set_flip_h(false)

	elif Input.is_action_pressed("left"):
		$Sprite.set_flip_h(true)
		$Sprite/kije.set_flip_h(true)
		

	
	#animation
	if jumping || floating:
		anim.travel("idle")
	elif Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		anim.travel("walk")
	else:
		anim.travel("idle")

	
func _physics_process(delta):
	if !(base.state in ["game", "dialogue"]):
		return
	if focused && base.state == "game":
		get_input(delta)
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta * 70)
		jumping = false
	
	if !floating:
		velocity.y = clamp(velocity.y + gravity * delta, -1500, 1500)
		
	
	var snap = Vector2.DOWN if !jumping else Vector2.ZERO
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.is_in_group("push"):
			col.collider.apply_central_impulse(-col.normal * inertia)
	
	
func kije_climb(val):
	if val == true:
		$Sprite/kije.visible = true
		$kije.disabled = false
	else:
		$Sprite/kije.visible = false
		$kije.disabled = true
