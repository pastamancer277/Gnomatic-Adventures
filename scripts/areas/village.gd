extends area


func _on_to_forest_3_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Village1"):
		Global.scene_transit=true
		locationChange="Forest3"



func _on_to_forest_3_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Village1"):
		Global.scene_transit=false


func _on_to_farm_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Village1"):
		Global.scene_transit=true
		locationChange="Farm"


func _on_to_farm_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Village1"):
		Global.scene_transit=false
