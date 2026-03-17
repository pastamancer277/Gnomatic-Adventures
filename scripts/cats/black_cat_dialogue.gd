extends Node

var run=1
var dialogueBox
var tamingQuest

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	tamingQuest=get_node("../Quests/TamingQuest")

func interact():
	if(run==1):
		dialogueBox.dialogue("Are you here to help me?", self)
		dialogueBox.setDialogueOption("Of course!", 0)
		dialogueBox.setDialogueOption("No, I'm here to fight!", 1)
		dialogueBox.setDialogueOption("I'm just passing through...", 2)
	if(run==2):
		dialogueBox.dialogue("Great! I need three fish and five meat!", self)
		dialogueBox.setDialogueOption("Here you go!", 0)
		dialogueBox.setDialogueOption("Give me a second.", 1)
	if(run==3):
		dialogueBox.dialogue("Fine then...", self)
		dialogueBox.setDialogueOption("CHARGE!", 0)
	if(run==4):
		dialogueBox.dialogue("I will join you in your quest!", self)
		dialogueBox.setDialogueOption("Fantastic", 0)

func playerResponse(key:int):
	if(run==1):
		if(key==0):
			run=2
			tamingQuest.activate()
			interact()
		if(key==1):
			run=3
			interact()
		if(key==2):
			pass
	else: if(run==2):
		if(key==0):
			tamingQuest.tryComplete()
			if(tamingQuest.isComplete()):
				run=4
		if(key==1):
			pass
	else: if(run==3):
		get_parent().setCombat(true)
	else: if(run==4):
		get_parent().questComplete()
