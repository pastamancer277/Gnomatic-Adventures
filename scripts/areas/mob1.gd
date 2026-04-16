extends area


# Called when the node enters the scene tree for the first time.


func _on_to_city_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Mob1"):
		Global.scene_transit=true
		locationChange="City1"


func _on_to_city_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=false
