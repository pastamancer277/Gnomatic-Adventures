extends CharacterBody2D

class_name enemy

@export var enemyResource: enemy_res
@onready var item = preload("res://scenes/map_item.tscn")
@onready var playerNode = $/root/Main/Sort/PlayerEntities/Player

var player_chase = []
var player_attacks=[]
var attack_cooldown=true
var dead=false

var mHealth
var health
var attack_value
var speed
var attack_speed
var knockback
var regen_speed
var regen_amount
var respawn_time
var xpValue

var pos

var knockback_velocity = Vector2.ZERO

func _ready() -> void:
	playerNode.resetGame.connect(reset)
	
	pos=global_position
	
	attack_speed=enemyResource.attackCooldown
	regen_speed=enemyResource.regenSpeed
	regen_amount=enemyResource.regenAmount
	knockback=enemyResource.knockback
	respawn_time=enemyResource.respawnTime
	xpValue=enemyResource.xpValue
	
	mHealth=enemyResource.maxHealth
	health=mHealth
	$HealthBar.max_value = mHealth
	attack_value=enemyResource.attackValue
	speed=enemyResource.speed
	var colShape=CircleShape2D.new()
	colShape.radius=enemyResource.collisionRadius
	$CollisionShape2D.shape=colShape
	var atShape=CircleShape2D.new()
	atShape.radius=enemyResource.attackRadius
	$AttackBox/CollisionShape2D.shape=atShape
	var detShape=CircleShape2D.new()
	detShape.radius=enemyResource.sightRadius
	$DetectionArea/CollisionShape2D.shape=detShape
	$AnimatedSprite2D.sprite_frames=enemyResource.animations
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	if(not dead and !$/root/Global.getPaused()):
		$CollisionShape2D.disabled=false
		visible=true
		update_health()
		attack()
		move()
	else:
		$CollisionShape2D.disabled=true
		visible=false

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
	if(!player_attacks.is_empty() and attack_cooldown and not health==0):
		for p in player_attacks:
			p.damage(attack_value, global_position, knockback)
		attack_cooldown=false
		$AttackCooldown.start(attack_speed)

func move():
	if knockback_velocity.length() > 10:
		velocity = knockback_velocity
		knockback_velocity = lerp(knockback_velocity, Vector2.ZERO, 0.1)
	else:
		velocity = Vector2.ZERO
		if(!player_chase.is_empty() and health>0):
			var p=player_chase.get(0)
			$AnimatedSprite2D.play("walk")
			if(p.position.x-position.x<0):
				velocity.x=-speed
				$AnimatedSprite2D.flip_h=true
			else:
				velocity.x=speed
				$AnimatedSprite2D.flip_h=false
			if(p.position.y-position.y<0):
				velocity.y=-speed
			else:
				velocity.y=speed
		else: if(health>0):
			velocity.x=0
			velocity.y=0
			$AnimatedSprite2D.play("idle")
		else: if(health<=0):
			velocity.x=0
			velocity.y=0
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player_chase.append(body)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player_chase.erase(body)

func _on_attackbox_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player_attacks.append(body)

func _on_attackbox_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player_attacks.erase(body)

func _on_attack_cooldown_timeout() -> void:
	attack_cooldown=true

func damage(d: int, attackPos, knockback):
	var material = $AnimatedSprite2D.material
	if material is ShaderMaterial:
		material.set_shader_parameter("active", true)
		
		var tween = create_tween()
		tween.tween_interval(0.1)
		tween.finished.connect(func(): 
			material.set_shader_parameter("active", false)
		)
	
	var dir = global_position.direction_to(attackPos)
	var push_dir = (global_position - attackPos).normalized()
	knockback_velocity = push_dir * knockback
	
	health-=d
	if(health<=0):
		$AnimationPlayer.play("death")
	else:
		$RegenTimer.start(regen_speed)

func dropItems():
	for term in enemyResource.items:
		var am: int = term.amount
		for count in range(am):
			var i = item.instantiate()
			i.setup(term.file)
			i.setPosition(global_position, enemyResource.collisionRadius)
			add_sibling(i)

func _on_regen_timer_timeout() -> void:
	if(health<mHealth and health>0):
		health=health+regen_amount
		if(health>mHealth):
			health=mHealth

func onDeath():
	dropItems()
	playerNode.gainXP(xpValue)
	visible=false
	$CollisionShape2D.disabled=true
	dead=true
	$RespawnTimer.start(respawn_time)

func _on_respawn_timer_timeout():
	global_position=pos
	visible=true
	$CollisionShape2D.disabled=false
	process_mode=Node.PROCESS_MODE_INHERIT
	health=mHealth
	dead=false

func isDead():
	return dead

func reset():
	_on_respawn_timer_timeout()
