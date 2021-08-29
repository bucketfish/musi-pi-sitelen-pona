extends StaticBody2D

export var id:String

# Called when the node enters the scene tree for the first time.
func _ready():
	init_jo()

func init_jo():
	if id in persistent.sona["jo"]:

		visible = true
		$anim.play("fadein")
		set_collision_mask_bit(0, true)
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(1, true)
		set_collision_layer_bit(1, true)

	else:
		visible = false
		set_collision_mask_bit(0, false)
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(1, false)
		set_collision_layer_bit(1, false)
		
func check(thing):
	if id == thing:

		visible = true
		$anim.play("fadein")
		set_collision_mask_bit(0, true)
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(1, true)
		set_collision_layer_bit(1, true)

		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
