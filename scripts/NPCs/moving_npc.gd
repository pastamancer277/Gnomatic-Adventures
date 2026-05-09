extends CharacterBody2D

var player_near = false
var loc
var pos
var target : Vector2
var attack=true
var active = false

@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var grandma = $/root/Main/Sort/Areas/StartingVillage/Entities/GrandmaNPC/Dialogue

func _ready() -> void:
	grandma.chase.connect(activate)
	loc=get_parent().get_parent().name
	pos=global_position
	target=get_node("../Targets/ExitTar").global_position
	visible=false

func activate():
	active=true
	visible=true

func _process(delta):
	if(loc==$/root/Global.getCurArea() and active):
		var a=target.angle_to_point(player.global_position)
		var p = player.global_position
		var x=p.x+cos(a)*15
		var y=p.y+sin(a)*15
		var t = Vector2(x,y)
		var direction = global_position.direction_to(t)
		velocity = direction * 80
		move_and_slide()
		if(player_near and attack and global_position.distance_to(t)<7):
			player.damage(1, global_position, 190)
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
