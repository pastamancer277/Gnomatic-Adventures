extends CharacterBody2D

class_name chest

var player
var open=false

func _process(delta):
	if !player==null and Input.is_action_just_pressed("Interact"):
		$Interact.interact(player)

func setOpen(o):
	open=o

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player=body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player=null

func saveData():
	$"/root/SaveManager".addSaveData("Chests", name, {"open" = open})

func loadData():
	var data = $"/root/SaveManager".getData("Chests", name)
	open = data.get("open", false)
	if(open == true):
		$AnimatedSprite2D.play("setOpen")
	else:
		$AnimatedSprite2D.play("setClosed")
