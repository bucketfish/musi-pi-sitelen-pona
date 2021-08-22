extends Area2D


export var ijo_id:String

signal jo(id)
# Called when the node enters the scene tree for the first time.
func _ready():
	check()
		
func check():
	if ijo_id in persistent.sona["jo"]:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_body_entered(body):
	if body.is_in_group("lon tawa"):
		emit_signal("jo", ijo_id)
		persistent.add_jo(ijo_id)
		queue_free()
