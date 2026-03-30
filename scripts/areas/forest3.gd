extends area


func _on_cliffside_transit_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest3"):
		locationChange="Forest2"
		Global.scene_transit=true

func _on_cliffside_transit_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest3"):
		Global.scene_transit=false
