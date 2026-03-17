extends area

var locationChange

func _ready():
	$/root/Main/Sort/PlayerEntities/Player.position.x=Global.player_start_x
	$/root/Main/Sort/PlayerEntities/Player.position.y=Global.player_start_y

func _on_cliffside_transit_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest2"):
		Global.scene_transit=true
		locationChange="Forest1"

func _on_cliffside_transit_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest2"):
		Global.scene_transit=false
		locationChange="Forest1"

func _on_to_city_body_entered(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest2"):
		if(body.hasKeyword("forest_clear")):
			Global.scene_transit=true
			locationChange="City1"


func _on_to_city_body_exited(body: Node2D) -> void:
	if(body.name=="Player"&&Global.cur_area=="Forest2"):
		if(body.hasKeyword("forest_clear")):
			Global.scene_transit=true
			locationChange="City1"

func change_scene():
	if(Global.scene_transit):
		if(Global.cur_area=="Forest2"):
			Global.finish_scene_change(locationChange)
			visible=false
