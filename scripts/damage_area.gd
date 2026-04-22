extends Node2D

var damage
var targets:Array

func _process(_delta: float) -> void:
	targets = targets.filter(func(target): return is_instance_valid(target))

func setup(sp, d):
	damage=d
	$Sprite2D.texture = sp

func _on_area_2d_body_entered(body: Node2D) -> void:
	targets.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)


func _on_damage_timer_timeout() -> void:
	for tar in targets:
		tar.damage(damage, global_position, 0)


func _on_timer_timeout() -> void:
	queue_free()
