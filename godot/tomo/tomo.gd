extends Node2D


export var spawns = 0
export var tomo_id:String

onready var base = get_node("/root/ale")

signal change_done

func on_scene_change(id):
	var player = base.current
	
	for i in range(spawns):
		var spawn = get_node("spawn" + str(i+1))
		if spawn.spawn_id == id:
			print(id + ' -> ' + spawn.spawn_id)
			player.global_position = spawn.global_position
			print(player.position)
			print(spawn.position)
			break
			#camera.global_position = player.global_position	

	emit_signal("change_done")
