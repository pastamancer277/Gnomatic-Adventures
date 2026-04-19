extends dialogue

var meatQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	meatQuest=get_node("../Quests/FurQuest")

func interact():
	if(run==1):
	
			dialogueBox.dialogue("oh no oh no", self)
			dialogueBox.setDialogueOption("Hello what's wrong?", 0)
			dialogueBox.setDialogueOption("...Bye", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("I need to get fur to make a blanket. The furtrader is missing tho. Can you get me fur?",self)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Did you bring the fur?",self)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if(run==4):
		run = 5
	else: if run == 5:
		dialogueBox.dialogue("Thank you so much! Now I can make my blanket!",self)
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
