extends Node

var run=1

var dialogueBox
var slimeQuest

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	slimeQuest=get_node("../Quests/SlimeQuest")

func interact():
	if(run==1):
		dialogueBox.dialogue("Hello there", self)
		dialogueBox.setDialogueOption("Hi", 0)
		dialogueBox.setDialogueOption("Ugh, people", 1)
	else: if(run==2):
		dialogueBox.dialogue("Can you kill those three slimes, and bring me the slime?",self)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Have you killed the slimes?",self)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if(run==4):
		dialogueBox.dialogue("Thank you so much!",self)
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
			slimeQuest.activate()
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			slimeQuest.tryComplete()
			if(slimeQuest.isComplete()):
				run+=1
				interact()
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass
