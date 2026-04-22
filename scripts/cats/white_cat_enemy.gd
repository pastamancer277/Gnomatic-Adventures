extends catEnemy

var summon = false
var fire = false
var hair = false
var phase = 3

@export var enemyScene:PackedScene
@export var fireballScene:PackedScene
@export var damageArea:PackedScene
@export var hairImage: Texture

@export var rabbit: Resource
@export var deer: Resource
@export var bear: Resource

func _ready():
	super._ready()
	
	mHealth=150
	health=mHealth
	attack_value=35
	knockback = 120.0
	speed=55
	attack_speed=.8
	regen_speed=1
	regen_amount=15
	respawn_time=null
	xpValue=50

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if(combat):
		if(summon):
			summonMinion()
			summon=false
		if(fire):
			fireball()
			fire=false

func setCombat(c: bool):
	combat=c
	summon=true
	fire=true
	hair=true

func move():
	super.move()
	if(phase==3 and hair):
		hairDrop()
		hair=false

func summonMinion():
	var s = enemyScene.instantiate()
	if(phase==1):
		s.setRes(rabbit)
	if(phase==2):
		s.setRes(deer)
	if(phase==3):
		s.setRes(bear)
	s.global_position=global_position
	s.setSummon(true)
	add_sibling(s)
	$SummonTimer.start()

func fireball():
	var f = fireballScene.instantiate()
	f.global_position=global_position
	var dir = global_position.direction_to(player.global_position)
	f.setup(dir.x*150, dir.y*150, 250, attack_value*0.7, phase, player)
	add_sibling(f)
	$FireballTimer.start()

func hairDrop():
	var h = damageArea.instantiate()
	h.global_position= global_position
	h.setup(hairImage, 5)
	add_sibling(h)
	$HairTimer.start()

func onDeath():
	if(phase==3):
		super.onDeath()
	else:
		summonMinion()
		summonMinion()
		phase+=1
		health=mHealth
		fireball()
		summonMinion()

func _on_summon_timer_timeout() -> void:
	summon=true

func _on_fireball_timer_timeout() -> void:
	fire=true

func _on_hair_timer_timeout() -> void:
	hair=true
