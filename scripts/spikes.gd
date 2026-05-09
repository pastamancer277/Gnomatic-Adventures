extends Node2D

var damage=10
var targets=[]

func _ready() -> void:
	$Sprite2D2.visible=false
	$Sprite2D3.visible=false
	$Timer.start(randf()*2)

func lift():
	$Sprite2D.visible=false
	$Sprite2D2.visible=true

func hit():
	$Sprite2D2.visible=false
	$Sprite2D3.visible=true
	for tar in targets:
		tar.damage(damage, global_position, 0)

func down():
	$Sprite2D3.visible=false
	$Sprite2D.visible=true
	$Timer.start(randf()*2+3)

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("attack")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		targets.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if targets.has(body):
		targets.erase(body)
