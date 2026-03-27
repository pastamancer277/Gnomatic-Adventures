extends CharacterBody2D

var resource: allyResource
@onready var player = $/root/Main/Sort/PlayerEntities/Player

var target=[]
var target_chase=[]
var attack_cooldown=true
var dead=false

var mHealth
var health
var attack_value
var speed
var knockback

var knockback_velocity = Vector2.ZERO

func setup(res: allyResource, pos: Vector2) -> void:
	if not is_node_ready():
		await ready
	
	global_position=pos
	resource=res
	mHealth=resource.maxHealth
	health=mHealth
	knockback=resource.knockback
	$HealthBar.max_value = mHealth
	attack_value=resource.attackValue
	speed=resource.speed
	var colShape=CircleShape2D.new()
	colShape.radius=resource.collisionRadius
	$CollisionShape2D.shape=colShape
	var atShape=CircleShape2D.new()
	atShape.radius=resource.attackRadius
	$AttackBox/CollisionShape2D.shape=atShape
	var detShape=CircleShape2D.new()
	detShape.radius=resource.sightRadius
	$DetectionArea/CollisionShape2D.shape=detShape
	$AnimatedSprite2D.sprite_frames=resource.animations
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	for enemy in target_chase:
		if enemy.isDead():
			target_chase.erase(enemy)
	for enemy in target:
		if enemy.isDead():
			target.erase(enemy)
	
	update_health()
	attack()
	move()

func update_health():
	if(health<=0):
		health=0
	
	var hBar= $HealthBar
	hBar.value=health
	
	if(health>=mHealth):
		hBar.visible=false
	else:
		hBar.visible=true

func attack():
	if(!target.is_empty() and attack_cooldown and not health<=0):
		for enemy in target:
			enemy.damage(attack_value, global_position, knockback)
		attack_cooldown=false
		$AttackCooldown.start(resource.attackCooldown)
	#else:
		#print(target)
		#print(attack_cooldown)
		#print(health)

func move():
	if knockback_velocity.length() > 10:
		velocity = knockback_velocity
		knockback_velocity = lerp(knockback_velocity, Vector2.ZERO, 0.1)
	else:
		velocity = Vector2.ZERO
		if(!target_chase.is_empty() and health>0):
			var moveTar=target_chase.get(0)
			$AnimatedSprite2D.play("walk")
			if(moveTar.position.x-position.x<0):
				velocity.x=-speed
				$AnimatedSprite2D.flip_h=true
			else:
				velocity.x=speed
				$AnimatedSprite2D.flip_h=false
			if(moveTar.position.y-position.y<0):
				velocity.y=-speed
			else:
				velocity.y=speed
		else: if(health<=0):
			velocity.x=0
			velocity.y=0
		else: if(global_position.distance_to(player.global_position)>50):
			$AnimatedSprite2D.play("walk")
			if(player.position.x-position.x<0):
				velocity.x=-speed
				$AnimatedSprite2D.flip_h=true
			else:
				velocity.x=speed
				$AnimatedSprite2D.flip_h=false
			if(player.position.y-position.y<0):
				velocity.y=-speed
			else:
				velocity.y=speed
		else: if(health>0):
			velocity.x=0
			velocity.y=0
			$AnimatedSprite2D.play("idle")
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("enemy")):
		target_chase.append(body)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if(target_chase.has(body)):
		target_chase.erase(body)

func _on_attackbox_body_entered(body: Node2D) -> void:
	if(body.is_in_group("enemy")):
		target.append(body)

func _on_attackbox_body_exited(body: Node2D) -> void:
	if(target.has(body)):
		target_chase.erase(body)

func _on_attack_cooldown_timeout() -> void:
	attack_cooldown=true

func damage(damage:int, pos, knock):
	var material = $AnimatedSprite2D.material
	if material is ShaderMaterial:
		material.set_shader_parameter("active", true)
		
		var tween = create_tween()
		tween.tween_interval(0.1)
		tween.finished.connect(func(): 
			material.set_shader_parameter("active", false)
		)
	
	var dir = global_position.direction_to(pos)
	var push_dir = (global_position - pos).normalized()
	knockback_velocity = push_dir * knock
	
	health-=damage
	if(health>0):
		$RegenTimer.start(resource.regenSpeed)
	else:
		onDeath()

func _on_regen_timer_timeout() -> void:
	if(health<mHealth and health>0):
		health=health+resource.regenAmount
		if(health>mHealth):
			health=mHealth

func onDeath():
	visible=false
	$CollisionShape2D.disabled=true
	dead=true
	$RespawnTimer.start(resource.respawnTime)

func _on_respawn_timer_timeout():
	global_position=player.getPos()
	visible=true
	$CollisionShape2D.disabled=false
	process_mode=Node.PROCESS_MODE_INHERIT
	health=mHealth
	dead=false
