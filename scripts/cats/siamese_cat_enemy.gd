extends catEnemy

var spike = false
var spikeList=[]
var phase=1

@export var spikeScene: PackedScene
@onready var blackAlly = preload("res://resources/allyCats/siameseCatAlly.tres")

func _ready():
	super._ready()
	
	mHealth=200
	health=mHealth
	attack_value=25
	knockback = 180.0
	speed=40
	attack_speed=.8
	regen_speed=1.5
	regen_amount=20
	respawn_time=null
	xpValue=60

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if(combat and not dead):
		if(spike):
			spikes()

func spikes():
	spike=false
	$"Spike Timer".start()
	var s = spikeScene.instantiate()
	s.global_position.x = global_position.x+((randf()-.5)*300)
	s.global_position.y = global_position.y+((randf()-.5)*300)
	add_sibling(s)
	spikeList.append(s)

func setCombat(c: bool):
	super.setCombat(c)
	$"Spike Timer".start()

func onDeath():
	if(phase==1):
		phase=2
		health=mHealth
		$"Spike Timer".start(.9)
	else:
		$Dialogue.interact()

func clearSpikes():
	for s in spikeList:
		s.queue_free()

func questComplete():
	var ally = allyScene.instantiate()
	$/root/Main/Sort/PlayerEntities.add_child(ally)
	$/root/Main/Sort/PlayerEntities/Player.addKeyword("siamese_cat")
	ally.setup(blackAlly, playerNode.global_position)
	playerNode.changeCredit(-12)
	disappear()

func loadTamed():
	super.loadTamed()
	
	var ally = allyScene.instantiate()
	$/root/Main/Sort/PlayerEntities.add_child(ally)
	ally.setup(blackAlly, playerNode.global_position)
	disappear()

func dropItems():
	pass

func _on_spike_timer_timeout() -> void:
	spike=true
