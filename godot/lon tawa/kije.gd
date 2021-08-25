extends "res://lon tawa/tawa.gd"


#establish scene name for saving
export var scene_id = "kije"
signal climb


func _ready():
	raycasts = {
		"floor": [$floor1, $floor2, $floor3],
		"left": [$climbl1, $climbl2, $climbl3],
		"right": [$climbr1, $climbr2, $climbr3],
	}
	connect("climb", get_parent().get_parent(), "kije_climb")
	inertia = 10
	init_jo()
	$RemoteTransform2D.remote_path = "/root/ale/Camera2D"
	
func init_jo():
	if !(scene_id in persistent.sona["jo"]):
		visible = false
		$"collision box".disabled = true
	else:
		pass
		
func check(thing):
	if scene_id == thing:
		emit_signal("climb")
		queue_free()


func get_input(delta):
	#settle these variables first
	var onfloor = raycast("floor")
	var wall_l = raycast("left") && Input.is_action_pressed("left")
	var wall_r = raycast("right") && Input.is_action_pressed("right")
	wall = wall_l || wall_r
	
	
	
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
	
	
	if Input.is_action_pressed("jump"):
		if wall:
			velocity.y = -climbspeed
		if raycast_climb("right") || raycast_climb("left") || raycast_climb("floor"):
			emit_signal("climb")
			queue_free()
			

	#left + right movement
	if Input.is_action_pressed("right"):
		$Sprite.set_flip_h(false)

	elif Input.is_action_pressed("left"):
		$Sprite.set_flip_h(true)
	
	#animation
	if jumping:
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
		
	if wall:
		velocity.y = clamp(velocity.y + wgravity * delta, -1500, 200)

	if !floating:
		velocity.y = clamp(velocity.y + gravity * delta, -1500, 1500)
		
	var snap = Vector2.DOWN if !jumping else Vector2.ZERO
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.is_in_group("push"):
			col.collider.apply_central_impulse(-col.normal * inertia)
	
	
	
func raycast_climb(area):
	for i in raycasts[area]:
		if i.is_colliding():
			if i.get_collider().is_in_group("soweli"):
				return true
	return false
	
