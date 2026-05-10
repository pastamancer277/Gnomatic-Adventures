extends CharacterBody2D

var player_near = false
var loc
var pos
var target : Vector2
var attack=true
var active = false

var speed = 80
var knockback= 190

@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var grandma = $/root/Main/Sort/Areas/StartingVillage/Entities/GrandmaNPC/Dialogue

func _ready() -> void:
	grandma.chase.connect(activate)
	loc=get_parent().get_parent().name
	pos=global_position
	target=get_node("../Targets/ExitTar").global_position

func activate():
	active=true
	visible=true
	$CollisionShape2D.disabled=false

func _process(delta):
	if(not active):
		visible=false
		$CollisionShape2D.disabled=true
	if(loc==$/root/Global.getCurArea() and active and not $/root/Global.getPaused()):
		var a=target.angle_to_point(player.global_position)
		var p = player.global_position
		var x=p.x+cos(a)*15
		var y=p.y+sin(a)*15
		var t = Vector2(x,y)
		var direction = global_position.direction_to(t)
		velocity = direction * speed
		move_and_slide()
		if(player_near and attack and global_position.distance_to(t)<7):
			player.damage(1, global_position, knockback)
			attack=false
			$Attack.start()


func _on_area_2d_body_entered(body):
	if(loc==$/root/Global.getCurArea()):
		if body.name == "Player":
			player_near = true

func _on_area_2d_body_exited(body):
	if(loc==$/root/Global.getCurArea()):
		if body.name == "Player":
			player_near = false

func reset():
	visible=true
	$CollisionShape2D.disabled=false
	$Area2D/CollisionShape2D.disabled=false
	global_position=pos

func _on_attack_timeout() -> void:
	attack=true

func moveBack():
	if active:
		global_position = get_node("../Targets/Back").global_position
