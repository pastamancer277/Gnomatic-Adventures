extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func interact():
	if(run==1):
		dialogueBox.dialogue("There's a dangerous cat somewhere in this forest! I'm sorry, but I can't let anyone through until the cat is dealt with, and I'm afraid The Catwatch Crew won't be dispatched until a couple days from now. So unless YOU want to deal with it, you cannot pass.", self)
		dialogueBox.setDialogueOption("I'm going to find that cat and deal with it myself.", 0)
		dialogueBox.setDialogueOption("I already dealt with it", 1)
	else: if(run==2):
		dialogueBox.dialogue("My gnome senses tell me there's still danger in this forest. I know you're lying.",self)
		dialogueBox.setDialogueOption("Well you don't have to be so rude about it", 0)
	else: if(run==3):
		dialogueBox.dialogue("Wow! That's impressive! I suppose I can reopen the path.",self)
		dialogueBox.setDialogueOption("Great, thanks.", 0)
	else: if(run==4):
		dialogueBox.dialogue("The path is open.",self)
		dialogueBox.setDialogueOption("Thank you.", 0)

func playerResponse(key: int):
	if(run==1):
		if(key==0):
			pass
		else: if(key==1):
			if(player.hasKeyword("black_cat")):
				run=3
				interact()
			else:
				run=2
				interact()
	else: if(run==2):
		run=1
	else: if(run==3):
		run=4
		player.addKeyword("forest_clear")
	else: if(run==4):
		pass
