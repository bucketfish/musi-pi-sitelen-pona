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
		selected = !selected

		get_parent().choose(self, ijo_group)
			
		$RichTextLabel.text = str(selected)
		
		#queue_free()
func ijo_select(thing, group, val):

	if group == ijo_group:
		if thing == ijo_id && val:
			$show.play("kalama")
		else:
			$show.play("none")
