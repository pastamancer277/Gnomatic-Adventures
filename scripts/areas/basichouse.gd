extends area

var exitLoc
var exitPos

func enterFrom(node:String):
	exitLoc=node
	exitPos = player.global_position
	player.global_position = $EnterPoints/Door.global_position

func _on_exit_body_entered(body: Node2D) -> void:
	if(body.name == "Player"&&Global.cur_area==name):
		Global.scene_transit=true
		locationChange=exitLoc
		player.global_position = exitPos
		player.global_position.y = player.global_position.y + 15


func _on_exit_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		Global.scene_transit = false
