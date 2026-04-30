extends dialogue

var pQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	pQuest=get_node("../Quests/PolmegranateQuest")
	person_name = "Duck"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/Duck.png").get_image()
	im = im.get_region(Rect2(0,0, im.get_width(), im.get_height()))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
	
			dialogueBox.dialogue("Do you have any pomegranates?", self,person_name, tex)
			dialogueBox.setDialogueOption("No, why?", 0)
			dialogueBox.setDialogueOption("Eww no!", 1)
		
	else: if(run==2):
		dialogueBox.dialogue("I love pomegranates but this guy dosn't have any, can you get me some?",self,person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose", 1)
		dialogueBox.setDialogueOption("No, I'm busy", 2)
	else: if(run==3):
		dialogueBox.dialogue("pomegranate?",self,person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here.", 0)
		dialogueBox.setDialogueOption("No, your're SO annoying.", 1)
	else: if(run==4):
		dialogueBox.dialogue("Yay! Pomegranates! Thank you!",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome.", 0)

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
				player.add_keyword("duck")
		if(key==1):
			pass
	else: if(run==4):
		if(key==0):
			pass
