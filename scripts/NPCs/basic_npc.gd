extends Node2D

class_name npc

var player_near = false

func _process(delta):
	if player_near and Input.is_action_just_pressed("Interact") and !$/root/Global.getPaused():
		$/root/Main/UI/Dialogue.clearDialogue()
		interact()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_near = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_near = false
		$/root/Main/UI/Dialogue.clearDialogue()

func interact():
	$Dialogue.interact()
