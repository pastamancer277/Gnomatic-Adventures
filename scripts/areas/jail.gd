extends area

var inJail = false

func _ready() -> void:
	player.jailed.connect(sentToJail)

func _on_to_city_body_entered(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="Jail":
		locationChange="City2"
		Global.scene_transit=true


func _on_to_city_body_exited(body: Node2D) -> void:
	if body.name=="Player"&&Global.cur_area=="City2":
		Global.scene_transit=false

func sentToJail():
	player.global_position = $EnterPoints/InJail.global_position
	inJail=true
