extends area






func _on_to_village_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Country"):
		locationChange="Village1"
		Global.scene_transit=true


func _on_to_village_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Country"):
		Global.scene_transit=false
