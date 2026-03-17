extends CharacterBody2D

class_name chest

var player


func _process(delta):
	if !player==null and Input.is_action_just_pressed("Interact"):
		$Interact.interact(player)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player=body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player=null
