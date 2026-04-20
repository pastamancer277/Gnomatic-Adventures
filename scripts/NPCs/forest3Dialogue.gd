extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func interact():
	if(run==1):
		dialogueBox.dialogue("I need wood. Would you go hunt for a wood sprite to get some for me?.", self)
		dialogueBox.setDialogueOption("Ok!", 0)
		dialogueBox.setDialogueOption("I have your wood right here, sir.", 1)
	else: if(run==2):
		dialogueBox.dialogue("I think I'll need more.",self)
		dialogueBox.setDialogueOption("Ah, okay.", 0)
	else: if(run==3):
		run=4
	else: if(run==4):
		dialogueBox.dialogue("Thanks again.",self)
		dialogueBox.setDialogueOption("You're welcome!", 0)
		dialogueBox.setDialogueOption("Bye!", 0)

func playerResponse(key: int):
	if(run==1):
		if(key==0):
			pass
		else: if(key==1):
			get_node("../Quests/WoodQuest").tryComplete()
			if(get_node("../Quests/WoodQuest").isComplete()):
				run=3
				interact()
			else:
				run=2
				interact()
	else: if(run==2):
		run=1
	else: if(run==3):
		run=4
	else: if(run==4):
		pass
