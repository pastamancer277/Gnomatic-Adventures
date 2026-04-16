extends area


func _on__body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="City2":
		locationChange="City1"
		Global.scene_transit=true

func _on__body_exited(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="City2":
		Global.scene_transit=false

func _on_to_jail_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="City2":
		locationChange="Jail"
		Global.scene_transit=true

func _on_to_jail_body_exited(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="City2":
		Global.scene_transit=false
