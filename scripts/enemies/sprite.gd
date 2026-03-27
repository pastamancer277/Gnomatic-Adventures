extends CharacterBody2D

class_name sprite

@export var resource: sprite_res
@onready var item = preload("res://scenes/map_item.tscn")

var player_chase = false
var player=null
var dead=false

var mHealth
var health
var speed

var pos

var knockback_velocity = Vector2.ZERO

func _ready() -> void:
	pos=global_position
	
	mHealth=resource.maxHealth
	health=mHealth
	speed=resource.speed
	var colShape=CircleShape2D.new()
	colShape.radius=resource.collisionRadius
	$CollisionShape2D.shape=colShape
	var detShape=CircleShape2D.new()
	detShape.radius=resource.sightRadius
	$DetectionArea/CollisionShape2D.shape=detShape
	$AnimatedSprite2D.sprite_frames=resource.animations
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	if(not dead and !$/root/Global.getPaused()):
		$CollisionShape2D.disabled=false
		visible=true
		update_health()
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

func move():
	if knockback_velocity.length() > 10:
		velocity = knockback_velocity
		knockback_velocity = lerp(knockback_velocity, Vector2.ZERO, 0.1)
	else:
		velocity = Vector2.ZERO
		
		if player_chase and health>0:
			$AnimatedSprite2D.play("walk")
			if(player.position.x-position.x<0):
				velocity.x=speed
				$AnimatedSprite2D.flip_h=true
			else:
				velocity.x=-speed
				$AnimatedSprite2D.flip_h=false
			if(player.position.y-position.y<0):
				velocity.y=speed
			else:
				velocity.y=-speed
		else: if(health>0):
			velocity.x=0
			velocity.y=0
			$AnimatedSprite2D.play("idle")
		else: if(health<=0):
			velocity.x=0
			velocity.y=0
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player=body
	player_chase=true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player_chase=false
	player=null

func damage(d: int, pos, knock):
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
	
	health-=d
	if(health<=0):
		onDeath()
	else:
		$RegenTimer.start(resource.regenSpeed)

func hitBy(node: Node):
	if(node.name == "Player"):
		player_chase=true
		player=node

func dropItems():
	for term in resource.items:
		var am: int = term.amount
		for count in range(am):
			var i = item.instantiate()
			i.setup(term.file)
			i.setPosition(global_position, resource.collisionRadius)
			add_sibling(i)

func _on_regen_timer_timeout() -> void:
	if(health<mHealth and health>0):
		health=health+resource.regenAmount
		if(health>mHealth):
			health=mHealth

func onDeath():
	dropItems()
	visible=false
	$CollisionShape2D.disabled=true
	dead=true
	$RespawnTimer.start(resource.respawnTime)

func _on_respawn_timer_timeout():
	global_position=pos
	visible=true
	$CollisionShape2D.disabled=false
	process_mode=Node.PROCESS_MODE_INHERIT
	health=mHealth
	dead=false

func loadData():
	global_position=pos
	health=mHealth
	dead=false
	if(get_parent().get_parent().getActive()):
		visible=true
		$CollisionShape2D.disabled=false
		process_mode=Node.PROCESS_MODE_INHERIT
	else:
		visible=false
		$CollisionShape2D.disabled=true
		process_mode=Node.PROCESS_MODE_DISABLED
