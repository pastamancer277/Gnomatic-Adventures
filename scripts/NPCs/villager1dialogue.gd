extends dialogue

var meatQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	meatQuest=get_node("../Quests/FurQuest")
	person_name = "Glory"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
	
			dialogueBox.dialogue("Oh nooo, oh no no no!", self,person_name, tex)
			dialogueBox.setDialogueOption("Hello, what's troubling you?", 0)
			dialogueBox.setDialogueOption("...Bye", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("I need to get fur to make a blanket, but the fur trader is missing! Can you get me fur?",self,person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Did you bring the fur?",self,person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if(run==4):
		run = 5
	else: if run == 5:
		dialogueBox.dialogue("Thank you so much! Now I can make my blanket!",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome!", 0)

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
