extends Area2D

var targets:Array=[]

func attack(val: int, pos, knockback):
	if(targets.size()>0):
		for enemy in targets:
			enemy.damage(val, pos, knockback)

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("damagable")):
		targets.append(body)


func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("damagable")):
		targets.erase(body)
