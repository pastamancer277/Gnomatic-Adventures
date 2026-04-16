extends dialogue

@onready var key_item: Item = preload("res://resources/items/Polmegranate.tres")
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			dialogueBox.dialogue("Hello there", self)
			dialogueBox.setDialogueOption("Hi are you the polmegranate farmer?", 0)
			dialogueBox.setDialogueOption("Ugh, people", 1)
		else:
			dialogueBox.dialogue("Sorry i have other things to do", self)
			dialogueBox.setDialogueOption("...", 2)
	else: if(run==2):
		dialogueBox.dialogue("Yes I am is there anything i can help you with?",self)
		dialogueBox.setDialogueOption("Yes I need a polmegranate can I have one please", 0)
		dialogueBox.setDialogueOption("I need a polmegranate", 1)
		dialogueBox.setDialogueOption("Never mind", 2)
	else: if(run==3):
		dialogueBox.dialogue("Oh of course I have more than I know what to do with here you go",self)
		dialogueBox.setDialogueOption("Thank you!", 0)
		dialogueBox.setDialogueOption("Thanks", 1)
	

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
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
				run+=1
				interact()
				$/root/Main/Systems/Inventory.add_item({key_item:4})
		if(key==1):
			pass
