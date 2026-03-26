extends RigidBody2D

var range
var damage

func _physics_process(delta: float) -> void:
	range-=1
	if(range<=0):
		queue_free()

func setup(x, y, rangeV, damageV):
	var vec = Vector2(x,y)
	apply_central_impulse(vec)
	range=rangeV
	damage=damageV

func setPos(pos):
	global_position=pos

func getDamage():
	return damage


func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("enemy")):
		body.damage(damage, global_position, 0)
		queue_free()
