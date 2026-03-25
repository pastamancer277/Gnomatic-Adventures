extends catEnemy

@onready var blackAlly = preload("res://resources/allyCats/blackCatAlly.tres")

func _ready():
	super._ready()
	
	mHealth=150
	health=mHealth
	attack_value=12
	speed=50
	attack_speed=.6
	regen_speed=1.3
	regen_amount=15
	respawn_time=null
	xpValue=50

func questComplete():
	var ally = allyScene.instantiate()
	$/root/Main/Sort/PlayerEntities.add_child(ally)
	$/root/Main/Sort/PlayerEntities/Player.addKeyword("black_cat")
	ally.setup(blackAlly, global_position)
	playerNode.changeCredit(-8)
	disappear()

func onDeath():
	$/root/Main/Sort/PlayerEntities/Player.addKeyword("black_cat")
	playerNode.changeCredit(6)
	super.onDeath()

func dropItems():
	pass
