extends catEnemy

@onready var blackAlly = preload("res://resources/allyCats/brownCatAlly.tres")
var phase = 1
var dashLoad = false

func _ready():
	super._ready()
	
	mHealth=100
	health=mHealth
	attack_value=13
	knockback = 60.0
	speed=60
	attack_speed=.9
	regen_speed=1.0
	regen_amount=20
	respawn_time=null
	xpValue=65

func move():
	super.move()
	if(dashLoad):
		var dash_vector = Vector2.from_angle(randf_range(0, 2 * PI)) * (speed * 0.7)
		dashLoad = false
		$Dash.start()
		move_and_collide(dash_vector)

func questComplete():
	super.questComplete()
	
	var ally = allyScene.instantiate()
	$/root/Main/Sort/PlayerEntities.add_child(ally)
	$/root/Main/Sort/PlayerEntities/Player.addKeyword("brown_cat")
	ally.setup(blackAlly, playerNode.global_position)
	playerNode.changeCredit(-10)
	disappear()


func loadDataLate():
	super.loadDataLate()
	phase=1

func loadTamed():
	super.loadTamed()
	
	var ally = allyScene.instantiate()
	$/root/Main/Sort/PlayerEntities.add_child(ally)
	ally.setup(blackAlly, playerNode.global_position)
	disappear()

func onDeath():
	if(phase==1):
		health=mHealth
		phase+=1
		attack_value=23
		attack_speed=0.4
		$Dash.start()
	else:
		$/root/Main/Sort/PlayerEntities/Player.addKeyword("brown_cat")
		playerNode.changeCredit(6)
		super.onDeath()

func dropItems():
	pass

func _on_dash_timeout() -> void:
	dashLoad=true
