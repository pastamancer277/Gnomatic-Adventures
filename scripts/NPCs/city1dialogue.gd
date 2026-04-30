extends dialogue

var meatQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	meatQuest=get_node("../Quests/WoodQuest")
	person_name = "Juliet"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/Gnomester.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
			dialogueBox.dialogue("Hey, village kid", self, person_name, tex)
			dialogueBox.setDialogueOption("Are you talking to me?", 0)
			dialogueBox.setDialogueOption("I'm not a village kid jerk!", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("Yes you. I need wood to make a shelf. Can you get me wood?",self, person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("Did you bring the wood?",self, person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run ==4:
		dialogueBox.dialogue("Thanks",self)
		dialogueBox.setDialogueOption("You're welcome", 0, person_name, tex)

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
				$/root/Main/Systems/Inventory.add_item({gold:3})
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass
