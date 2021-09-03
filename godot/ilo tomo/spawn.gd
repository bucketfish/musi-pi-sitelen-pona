extends Position2D


export var detecting = true
export var spawn_towards:String
export var room_towards:String
export var spawn_id:String
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var base = get_node("/root/ale")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("lon tawa") && detecting:
		base.change_scene(room_towards, spawn_towards)
