extends Area2D


export var ijo_id:String
export var ijo_group = ""

export var selected = false


signal jo(id)
# Called when the node enters the scene tree for the first time.
func _ready():
	$show.play("none")
	$anim.play("a")
	
func _on_body_entered(body):
	if body.is_in_group("lon tawa"):
		emit_signal("jo", ijo_id)
		
		selected = !selected

		get_parent().choose(self, ijo_group)
			
		$RichTextLabel.text = str(selected)
		
		#queue_free()
func select(thing, group, val):
	print(thing + " " + group + " ;" + ijo_id + " " + ijo_group)
	
	if group == ijo_group:
		if thing == ijo_id && val:
			print(ijo_id + " CHOSEN")
			$show.play("kalama")
		else:
			print(ijo_id + " not")
			$show.play("none")
