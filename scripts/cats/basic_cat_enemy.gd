extends enemy

class_name catEnemy

var combat=false
var quest=false
var player=null

@onready var allyScene= preload("res://scenes/cats/basic_cat_ally.tscn")

func _physics_process(delta: float) -> void:
	if(combat and !$/root/Global.getPaused()):
		update_health()
		attack()
		move()
	else: if(not player == null):
		$HealthBar.visible=false
		if(Input.is_action_just_pressed("Interact")):
			runDialogue()

func playerEntered(body: Node2D):
	if(body.name=="Player" and !combat):
		runDialogue()
		player=body

func playerExited(body: Node2D):
	if(body.name=="Player" and !combat):
		$/root/Main/UI/Dialogue.clearDialogue()
		player=null

func setCombat(c: bool):
	combat=c
func setQuest(q: bool):
	quest=q

func runDialogue():
	$Dialogue.interact()

func questComplete():
	pass

func damage(d: int):
	if(combat):
		super.damage(d)

func onDeath():
	playerNode.gainXP(xpValue)
	dead=true
	queue_free()
