extends RigidBody2D

@export_file("*.tscn") var path: String = "res://scenes/rangedWeapons/fireball.tscn"
var range
var damage
var madeBy
var phase
var player
var vec

func _physics_process(delta: float) -> void:
	range-=1
	if(range<=0):
		if(phase>1):
			for i in range(0,4):
				var f = load(path).instantiate()
				f.global_position=global_position
				var dir = vec
				if(i==1):
					dir.x=-dir.x
				if(i==2):
					dir.y=-dir.y
				if(i==3):
					dir.x=-dir.x
					dir.y=-dir.y
				f.global_position.x+=dir.x*5
				f.global_position.y+=dir.y*5
				f.setup(dir.x*150, dir.y*150, 120, damage*0.7, 1, player)
				add_sibling(f)
		queue_free()

func setup(x, y, rangeV, damageV, phaseV, player):
	vec = Vector2(x,y)
	apply_central_impulse(vec)
	range=rangeV
	damage=damageV
	phase=phaseV

func setPos(pos):
	global_position=pos

func getDamage():
	return damage

func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("player")):
		body.damage(damage, global_position, 0)
	else:if(phase>1):
		for i in range(0,4):
			var f = load(path).instantiate()
			f.global_position=global_position
			var dir = vec/150
			if(i==1):
				dir.x=-dir.x
			if(i==2):
				dir.y=-dir.y
			if(i==3):
				dir.x=-dir.x
				dir.y=-dir.y
			f.global_position.x+=dir.x*5
			f.global_position.y+=dir.y*5
			f.setup(dir.x*150, dir.y*150, 2120, damage*0.7, 1, player)
			add_sibling(f)
	queue_free()
