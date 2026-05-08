extends area

var pie = true;

@onready var key_item: Item = preload("res://resources/items/Pie.tres")


func _on_houcevillage_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="GrandmaHouse":
		locationChange="StartingVillage"
		Global.scene_transit=true


func _on_houcevillage_body_exited(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="GrandmaHouse":
		Global.scene_transit=false


func _on_near_oven_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="GrandmaHouse":
		if pie:
			$/root/Main/Systems/Inventory.add_item({key_item:1})
			var popup_scene = load("res://scenes/popups.tscn").instantiate()
			$"/root/Main/UI/Popups".add_child(popup_scene)
			popup_scene.set_text("You got a pie!")
			$/root/Global.multiple_popups()
			pie=false
