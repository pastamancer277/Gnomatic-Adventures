extends area




func _on_houcevillage_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="GrandmaHouse":
		locationChange="StartingVillage"
		Global.scene_transit=true


func _on_houcevillage_body_exited(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="GrandmaHouse":
		Global.scene_transit=false
