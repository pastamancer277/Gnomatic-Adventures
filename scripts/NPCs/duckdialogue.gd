extends dialogue

var pQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	pQuest=get_node("../Quests/PolmegranateQuest")

func interact():
	if(run==1):
	
			dialogueBox.dialogue("Do you have any Polmegranates", self)
			dialogueBox.setDialogueOption("No why", 0)
			dialogueBox.setDialogueOption("Eww no", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("I love Polmegranates but this guy dosn't have any, can you get me some?",self)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Polmegranate?",self)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No,your so anoying", 1)
	else: if(run==4):
		dialogueBox.dialogue("Yay polmegranates! Thank you!",self)
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
			pQuest.activate()
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			pQuest.tryComplete()
			if(pQuest.isComplete()):
				run+=1
				interact()
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass
