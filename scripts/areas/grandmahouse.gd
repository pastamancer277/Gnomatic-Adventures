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
			pie=false
