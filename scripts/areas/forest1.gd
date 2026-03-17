extends area

func _on_cliffside_world_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="Forest1":
		Global.scene_transit=true


func _on_cliffside_world_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest1"):
		Global.scene_transit=false

func change_scene():
	if(Global.scene_transit):
		if Global.cur_area=="Forest1":
			Global.finish_scene_change("Forest2")
