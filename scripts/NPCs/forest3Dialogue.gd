extends Node

var run=1

var dialogueBox
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		dialogueBox.dialogue("I need wood Go fetch some wood sprites.", self)
		dialogueBox.setDialogueOption("Ok!", 0)
		dialogueBox.setDialogueOption("I have your wood right here sir", 1)
	else: if(run==2):
		dialogueBox.dialogue("Okay awesome.",self)
		dialogueBox.setDialogueOption("What do you plan to do with the wood?", 0)
	else: if(run==3):
		dialogueBox.dialogue("I will begin a house for myself, I think.",self)
		dialogueBox.setDialogueOption("Can't wait to see it!", 0)
	else: if(run==4):
		dialogueBox.dialogue("You may go now.",self)
		dialogueBox.setDialogueOption("Thanks!", 0)
		dialogueBox.setDialogueOption("Bye!", 0)

func playerResponse(key: int):
	if(run==1):
		if(key==0):
			pass
		else: if(key==1):
			if(player.hasKeyword("wood")):
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
