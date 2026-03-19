extends Node2D

class_name npc

var player_near = false
var loc

func _ready() -> void:
	loc=get_parent().get_parent().name

func _process(delta):
	if(loc==$/root/Global.getCurArea()):
		if player_near and Input.is_action_just_pressed("Interact") and !$/root/Global.getPaused():
			interact()

func _on_area_2d_body_entered(body):
	if(loc==$/root/Global.getCurArea()):
		if body.name == "Player":
			player_near = true

func _on_area_2d_body_exited(body):
	if(loc==$/root/Global.getCurArea()):
		if body.name == "Player":
			player_near = false
			$/root/Main/UI/Dialogue.clearDialogue($Dialogue)

func interact():
	if(loc==$/root/Global.getCurArea()):
		$Dialogue.interact()
