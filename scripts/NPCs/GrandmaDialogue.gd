extends dialogue

var slimeQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	slimeQuest=get_node("../Quests/SlimeQuest")

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			dialogueBox.dialogue("Hello there", self)
			dialogueBox.setDialogueOption("Hi.", 0)
			dialogueBox.setDialogueOption("Ugh, people...", 1)
		else:
			dialogueBox.dialogue("I don't know you. Come back when you're more popular.", self)
			dialogueBox.setDialogueOption("...", 2)
	else: if(run==2):
		dialogueBox.dialogue("Can you kill those animals and bring me the fur?",self)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose.", 1)
		dialogueBox.setDialogueOption("No, I'm busy.", 2)
	else: if(run==3):
		dialogueBox.dialogue("Have you killed the animals?",self)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run ==4:
		run = 5
	else: if(run==5):
		dialogueBox.dialogue("Thank you so much!",self)
		dialogueBox.setDialogueOption("You're welcome.", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
		else:
			pass
	else: if(run==2):
		if(key==0 or key==1):
			run+=1
			slimeQuest.activate()
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			slimeQuest.tryComplete()
			if(slimeQuest.isComplete()):
				run+=1
				interact()
				var popup_scene = load("res://scenes/popups.tscn").instantiate()
				$"/root/Main/UI/Popups".add_child(popup_scene)
				popup_scene.set_text("You gained a key! There must be a chest somewhere...")
				$/root/Global.multiple_popups()
		if(key==1):
			pass
	else: if(run==5):
		if(key==0):
			pass
