extends enemy

class_name catEnemy

var combat=false
var quest=false
var player=null

var tamed=false

@onready var allyScene= preload("res://scenes/cats/basic_cat_ally.tscn")

func _ready():
	$/root/SaveManager.loaded.connect(loadDataLate)
	playerNode.resetGame.connect(reset)
	pos=global_position

func _physics_process(delta: float) -> void:
	if dead:
		$CollisionShape2D.disabled=true
		visible=false
	else:
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
		player=body

func playerExited(body: Node2D):
	if(body.name=="Player" and !combat):
		$/root/Main/UI/Dialogue.clearDialogue($Dialogue)
		player=null

func setCombat(c: bool):
	combat=c
func setQuest(q: bool):
	quest=q

func runDialogue():
	$Dialogue.interact()

func questComplete():
	tamed=true

func damage(d: int, pos, knock):
	if(combat):
		super.damage(d, pos, knock)

func onDeath():
	playerNode.gainXP(xpValue)
	disappear()

func disappear():
	dead=true
	visible=false
	$CollisionShape2D.disabled=true
	$DetectionArea/CollisionShape2D.disabled=true

func reset():
	dead=false
	visible=true
	quest=false
	combat=false
	health=mHealth
	$CollisionShape2D.disabled=false
	$DetectionArea/CollisionShape2D.disabled=false
	global_position=pos
	$Dialogue.reset()

func saveData():
	$/root/SaveManager.addSaveData("NPCs", name, {"dead" = dead, "quest" = quest, "combat" = combat, "tamed" = tamed})

func loadDataLate():
	var data = $/root/SaveManager.getData("NPCs", name)
	if data.get("dead", false) == true:
		disappear()
	if data.get("tamed", false) == true:
		loadTamed()
	quest = data.get("quest", false)
	combat = data.get("combat", false)

func loadTamed():
	tamed=true
