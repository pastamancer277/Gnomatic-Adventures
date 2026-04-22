extends area


# Called when the node enters the scene tree for the first time.

func _on_to_forest_2_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="StartingVillage"):
		Global.scene_transit=true
		locationChange="Forest2"


func _on_to_forest_2_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="StartingVillage"):
		Global.scene_transit=false


func _on_to_start_forest_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="StartingVillage"):
		Global.scene_transit=true
		locationChange="StartingForest"


func _on_to_start_forest_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="StartingVillage"):
		Global.scene_transit=false
