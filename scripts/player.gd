extends CharacterBody2D

const SPEED = 100
var currnet_dir ="none"
var mHealth=100
var health=100
var attack_value=20
var shield=0
var alive=true
var attack_cooldown=true

var attacking=false

var level=1
var levelPoints=0
var xp=0
var socialCredit=50
var keywords=[]

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")
	$HealthBar.max_value=mHealth

func _physics_process(delta: float) -> void:
	if(alive&& !$/root/Global.getPaused()):
		player_movement(delta)
		update_health()
		
		if(Input.is_action_just_pressed("ui_accept")&&attack_cooldown):
			attack()
		if(Input.is_action_just_pressed("LevelAttack")):
			levelAttack()
		if(Input.is_action_just_pressed("LevelHealth")):
			levelHealth()
		if(Input.is_action_just_pressed("LevelShield")):
			levelShield()
	
	if(health<=0):
		alive=false;
		health=0
		$AnimationPlayer.play("death")

func player_movement(delta):
	if(Input.is_action_pressed("ui_right")):
		currnet_dir="right"
		play_anim(1)
		velocity.x=SPEED
		velocity.y=0
	elif(Input.is_action_pressed("ui_left")):
		currnet_dir="left"
		play_anim(1)
		velocity.x=-SPEED
		velocity.y=0
	elif(Input.is_action_pressed("ui_down")):
		currnet_dir="down"
		play_anim(1)
		velocity.y=SPEED
		velocity.x=0
	elif(Input.is_action_pressed("ui_up")):
		currnet_dir="up"
		play_anim(1)
		velocity.y=-SPEED
		velocity.x=0
	else:
		play_anim(0)
		velocity.x=0
		velocity.y=0
	
	move_and_slide()

func play_anim(move):
	var dir=currnet_dir
	var anim=$AnimatedSprite2D
	
	if(dir=="right"):
		anim.flip_h=false
		if(attacking):
			anim.play("side_attack")
		elif(move==1):
			anim.play("side_walk")
		elif(move==0):
			anim.play("side_idle")
	if(dir=="left"):
		anim.flip_h=true
		if(attacking):
			anim.play("side_attack")
		elif(move==1):
			anim.play("side_walk")
		elif(move==0):
			anim.play("side_idle")
	if(dir=="down"):
		anim.flip_h=false
		if(attacking):
			anim.play("front_attack")
		elif(move==1):
			anim.play("front_walk")
		elif(move==0):
			anim.play("front_idle")
	if(dir=="up"):
		anim.flip_h=false
		if(attacking):
			anim.play("back_attack")
		elif(move==1):
			anim.play("back_walk")
		elif(move==0):
			anim.play("back_idle")

func damage(damage:int):
	damage-=shield
	if(damage>0):
		health-=damage
		$RegenTimer.start()

func attack():
	attacking=true
	$AttackAnim.start()
	
	attack_cooldown=false
	$AttackCooldown.start()
	if(currnet_dir=="up"):
		$AttackUp.attack(attack_value)
	if(currnet_dir=="down"):
		$AttackDown.attack(attack_value)
	if(currnet_dir=="left"):
		$AttackLeft.attack(attack_value)
	if(currnet_dir=="right"):
		$AttackRight.attack(attack_value)

func update_health():
	var hBar= $HealthBar
	hBar.value=health
	
	if(health>=mHealth):
		hBar.visible=false
	else:
		hBar.visible=true

func _on_attack_cooldown_timeout() -> void:
	attack_cooldown=true

func _on_attack_anim_timeout() -> void:
	attacking=false;

func _on_regen_timer_timeout() -> void:
	if(health<mHealth and health>0):
		health=health+20
		if(health>mHealth):
			health=mHealth

func getPos():
	return global_position

func gainXP(val: int):
	xp+=val
	print(str(xp))
	if(xp>= 100):
		xp-=100
		level+=1
		levelPoints+=1

func changeCredit(val: int):
	socialCredit+=val
func getSocialCredit():
	return socialCredit

func levelAttack():
	if(levelPoints>0):
		levelPoints-=1
		attack_value+=3

func levelShield():
	if(levelPoints>0):
		levelPoints-=1
		shield+=1

func levelHealth():
	if(levelPoints>0):
		levelPoints-=1
		mHealth+=10
		health+=10
		$HealthBar.max_value=mHealth

func addKeyword(key: String):
	keywords.append(key)

func hasKeyword(key: String):
	return keywords.has(key)
