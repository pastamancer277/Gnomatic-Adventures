extends area


# Called when the node enters the scene tree for the first time.


func _on_jucecity_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="JuiceShop":
		locationChange="City1"
		Global.scene_transit=true
