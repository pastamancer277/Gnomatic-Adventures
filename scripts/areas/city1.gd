extends area


func _on_cityforest_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=true
		locationChange="Forest2"


func _on_cityforest_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=false


	pass # Replace with function body.


func _on_to_juice_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=true
		locationChange="JuiceShop"


func _on__body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=true
		locationChange="City2"


func _on_to_ally_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=true
		locationChange="Mob1"


func _on_to_ally_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=false



func _on__body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=false



func _on_to_juice_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="City1"):
		Global.scene_transit=false
