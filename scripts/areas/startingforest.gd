extends area




func _on_to_start_village_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="StartingForest":
		locationChange="StartingVillage"
		Global.scene_transit=true



func _on_to_start_village_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="StartingForest"):
		Global.scene_transit=false
