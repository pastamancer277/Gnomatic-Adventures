extends StaticBody2D

var player

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player!=null:
		$/root/SaveManager.saveGame()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player=body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body == player):
		player=null
