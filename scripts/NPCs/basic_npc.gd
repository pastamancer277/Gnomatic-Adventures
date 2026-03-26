extends Node2D

class_name npc

var player_near = false
var loc
var health = 100
var mHealth = 100
var dead
var killValue = 1

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	player.resetGame.connect(reset)
	loc=get_parent().get_parent().name
	$HealthBar.max_value=mHealth
	$HealthBar.value=health

func _process(delta):
	if(loc==$/root/Global.getCurArea()):
		update_health()
		if not dead and player_near and Input.is_action_just_pressed("Interact") and !$/root/Global.getPaused():
			interact()

func update_health():
	if(health<=0):
		health=0
	
	var hBar= $HealthBar
	hBar.value=health
	
	if(health>=mHealth):
		hBar.visible=false
	else:
		hBar.visible=true

func _on_area_2d_body_entered(body):
	if(loc==$/root/Global.getCurArea() and not dead):
		if body.name == "Player":
			player_near = true

func damage(d: int, pos, knock):
	var material = $Sprite2D.material
	if material is ShaderMaterial:
		material.set_shader_parameter("active", true)
		
		var tween = create_tween()
		tween.tween_interval(0.1)
		tween.finished.connect(func(): 
			material.set_shader_parameter("active", false)
		)
	
	health-=d
	if(health<=0):
		onDeath()
	else:
		$RegenTimer.start(3)

func onDeath():
	visible=false
	$CollisionShape2D.disabled=true
	$Area2D/CollisionShape2D.disabled=true
	dead=true
	player_near=false
	player.changeRating(killValue)

func _on_area_2d_body_exited(body):
	if(loc==$/root/Global.getCurArea()):
		if body.name == "Player":
			player_near = false
			$/root/Main/UI/Dialogue.clearDialogue($Dialogue)

func interact():
	if(loc==$/root/Global.getCurArea()):
		$Dialogue.interact()

func reset():
	$Dialogue.reset()
	visible=true
	$CollisionShape2D.disabled=false
	$Area2D/CollisionShape2D.disabled=false
	dead=false
	health=mHealth
