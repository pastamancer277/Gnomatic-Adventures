extends StaticBody2D

var player

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player!=null:
		$/root/SaveManager.saveGame()
		var popup_scene = load("res://scenes/popups.tscn").instantiate()
		$"/root/Main/UI/Popups".add_child(popup_scene)
		popup_scene.set_text("You saved your game!")
		$/root/Global.multiple_popups()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player=body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body == player):
		player=null
