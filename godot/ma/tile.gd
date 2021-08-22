extends TileMap

export var id:String
export(int, LAYERS_2D_PHYSICS) var layer
export(int, LAYERS_2D_PHYSICS) var mask

# Called when the node enters the scene tree for the first time.
func _ready():
	check()
	
func check():
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
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
