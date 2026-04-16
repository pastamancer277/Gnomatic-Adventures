extends CharacterBody2D

signal resetGame
signal respawn
signal jailed

@export var basicRanged: PackedScene

const SPEED = 100
var currnet_dir ="down"
var secDir = "none"
var mHealth=100
var health=100
var attack_value=20
var knockback = 120
var shield=0
var alive=true
var attack_cooldown=true

var killRating=0

var attacking=false

var level=1
var levelPoints=0
var xp=0
var socialCredit=50
var keywords=[]

var knockback_velocity = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")
	$HealthBar.max_value=mHealth

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("Reset")):
		reset()
	
	if(alive&& !$/root/Global.getPaused()):
		player_movement(delta)
		update_health()
		
		if(Input.is_action_just_pressed("MeleeAttack")&&attack_cooldown):
			attack()
		if(Input.is_action_just_pressed("RangedAttack")&&attack_cooldown):
			rangedAttack()
	
	if(health<=0 and alive):
		alive=false;
		health=0
		#$AnimationPlayer.play("death")
		_create_death_screen()
		print(get_window().size.x)
		print(get_window().size.y)

func _create_death_screen():
	var death = load("res://scenes/screens/death_screen.tscn").instantiate()
	$/root/Main/UI/Screens.add_child(death)

func player_movement(delta):
	if knockback_velocity.length() > 10:
		velocity = knockback_velocity
		knockback_velocity = lerp(knockback_velocity, Vector2.ZERO, 0.1)
	else:
		velocity = Vector2.ZERO
	
		if(Input.is_action_pressed("MoveRight")&&not Input.is_action_pressed("MoveLeft")):
			if(Input.is_action_pressed("MoveUp")&& not Input.is_action_pressed("MoveDown")):
				currnet_dir="right"
				secDir="up"
				play_anim(1)
				velocity.x=SPEED*sin(deg_to_rad(45))
				velocity.y=-SPEED*sin(deg_to_rad(45))
			elif(Input.is_action_pressed("MoveDown")&& not Input.is_action_pressed("MoveUp")):
				currnet_dir="right"
				secDir="down"
				play_anim(1)
				velocity.x=SPEED*sin(deg_to_rad(45))
				velocity.y=SPEED*sin(deg_to_rad(45))
			else:
				currnet_dir="right"
				secDir="none"
				play_anim(1)
				velocity.x=SPEED
				velocity.y=0
		elif(Input.is_action_pressed("MoveLeft")&&not Input.is_action_pressed("MoveRight")):
			if(Input.is_action_pressed("MoveUp")&& not Input.is_action_pressed("MoveDown")):
				currnet_dir="left"
				secDir="up"
				play_anim(1)
				velocity.x=-SPEED*sin(deg_to_rad(45))
				velocity.y=-SPEED*sin(deg_to_rad(45))
			elif(Input.is_action_pressed("MoveDown")&& not Input.is_action_pressed("MoveUp")):
				currnet_dir="left"
				secDir="down"
				play_anim(1)
				velocity.x=-SPEED*sin(deg_to_rad(45))
				velocity.y=SPEED*sin(deg_to_rad(45))
			else:
				currnet_dir="left"
				secDir="none"
				play_anim(1)
				velocity.x=-SPEED
				velocity.y=0
		elif(Input.is_action_pressed("MoveDown")&& not Input.is_action_pressed("MoveUp")):
			currnet_dir="down"
			secDir="none"
			play_anim(1)
			velocity.y=SPEED
			velocity.x=0
		elif(Input.is_action_pressed("MoveUp")&& not Input.is_action_pressed("MoveDown")):
			currnet_dir="up"
			secDir="none"
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

func damage(damage:int, pos, knock):
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
	
	damage-=shield
	if(damage>0):
		health-=damage
		$RegenTimer.start()

func attack():
	attacking=true
	$AttackAnim.start()
	
	attack_cooldown=false
	$AttackCooldown.start()
	$AnimationPlayer.play("attack")

func rangedAttack():
	attacking=true
	$AttackAnim.start()
	
	attack_cooldown=false
	$AttackCooldown.start()
	
	var shot=basicRanged.instantiate()
	var speed=180
	if(secDir!="none"):
		if(currnet_dir=="right"):
			if(secDir=="up"):
				shot.setup(speed*sin(PI/4),-speed*sin(PI/4),100,5)
			elif(secDir=="down"):
				shot.setup(speed*sin(PI/4),speed*sin(PI/4),100,5)
		if(currnet_dir=="left"):
			if(secDir=="up"):
				shot.setup(-speed*sin(PI/4),-speed*sin(PI/4),100,5)
			elif(secDir=="down"):
				shot.setup(-speed*sin(PI/4),speed*sin(PI/4),100,5)
		if(currnet_dir=="up"):
			if(secDir=="right"):
				shot.setup(speed*sin(PI/4),-speed*sin(PI/4),100,5)
			elif(secDir=="left"):
				shot.setup(-speed*sin(PI/4),-speed*sin(PI/4),100,5)
		if(currnet_dir=="down"):
			if(secDir=="right"):
				shot.setup(speed*sin(PI/4),speed*sin(PI/4),100,5)
			elif(secDir=="left"):
				shot.setup(-speed*sin(PI/4),speed*sin(PI/4),100,5)
	else:
		if(currnet_dir=="right"):
			shot.setup(100,0,100,5)
		if(currnet_dir=="left"):
			shot.setup(-100,0,100,5)
		if(currnet_dir=="up"):
			shot.setup(0,-100,100,5)
		if(currnet_dir=="down"):
			shot.setup(0,100,100,5)
	get_parent().add_child(shot)
	shot.setPos(global_position)

func hit():
	if(currnet_dir=="up"):
		$AttackUp.attack(attack_value, global_position, knockback)
	if(currnet_dir=="down"):
		$AttackDown.attack(attack_value, global_position, knockback)
	if(currnet_dir=="left"):
		$AttackLeft.attack(attack_value, global_position, knockback)
	if(currnet_dir=="right"):
		$AttackRight.attack(attack_value, global_position, knockback)

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

func setAllyPos():
	for ally in get_parent().get_children():
		if(ally != self):
			ally.global_position=global_position

func gainXP(val: int):
	xp+=val
	if(xp>= 100):
		xp-=100
		level+=1
		levelPoints+=1
		$"/root/Main/UI/UI Interface/VBoxContainer/HBoxContainer/VBoxContainer/Control2/Grid/Button".add_theme_stylebox_override("normal", load("res://assets/themes/red_notification_stylebox.tres"))
func getXP():
	return xp

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

func changeRating(val: int):
	killRating+=val
	if(killRating>0):
		$/root/Global.change_area("Jail")
		jailed.emit()

func reset():
	#resetGame.emit()
	#$/root/Global.resetGame()
	$/root/Main/UI/Dialogue.reset()
	
	currnet_dir ="down"
	$AnimatedSprite2D.play("idle")
	mHealth=100
	health=100
	attack_value=20
	shield=0
	alive=true
	attack_cooldown=true
	attacking=false
	killRating=0

	level=1
	levelPoints=0
	xp=0
	socialCredit=50
	keywords=[]

func saveData():
	var data={
		"locX" = global_position.x,
		"locY" = global_position.y,
		"mHealth" = mHealth,
		"health" = health,
		"attack_value"=attack_value,
		"knockback" = knockback,
		"shield"= shield,
		"alive"=alive,
		"killRating"=killRating,

		"level"=level,
		"levelPoints"=levelPoints,
		"xp"=xp,
		"socialCredit"=socialCredit,
		"keywords"=keywords
	}
	$/root/SaveManager.setSaveData("Player", data)

func loadData():
	var data = $/root/SaveManager.getAccessData("Player")
	
	if data == null or data.is_empty():
		return

	global_position.x = data["locX"]
	global_position.y = data["locY"]

	mHealth = data.get("mHealth", mHealth)
	health = data.get("health", health)
	attack_value = data.get("attack_value", attack_value)
	knockback = data.get("knockback", knockback)
	shield = data.get("shield", shield)
	alive = data.get("alive", alive)
	killRating = int(data.get("killRating", killRating))

	level = int(data.get("level", level))
	levelPoints = int(data.get("levelPoints", levelPoints))
	xp = data.get("xp", xp)
	socialCredit = int(data.get("socialCredit", socialCredit))
	keywords = data.get("keywords", keywords)
