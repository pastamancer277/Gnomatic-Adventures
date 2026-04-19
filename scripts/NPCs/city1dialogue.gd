extends dialogue

var meatQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	meatQuest=get_node("../Quests/WoodQuest")

func interact():
	if(run==1):
	
			dialogueBox.dialogue("Hey, village kid", self)
			dialogueBox.setDialogueOption("Are you talking to me?", 0)
			dialogueBox.setDialogueOption("I'm not a village kid jerk!", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("Yes you. I need wood to make a shelf. Can you get me wood?",self)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Did you bring the wood?",self)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run == 4:
		run = 5
	else: if run ==5:
		dialogueBox.dialogue("Thanks",self)
		dialogueBox.setDialogueOption("You're welcome", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
		
	else: if(run==2):
		if(key==0 or key==1):
			run+=1
			meatQuest.activate()
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			meatQuest.tryComplete()
			if(meatQuest.isComplete()):
				run+=1
				interact()
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass
