extends dialogue

var tamingQuest

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	tamingQuest=get_node("../Quests/TamingQuest")
	person_name = "Brown Cat"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/BrownCat_Free_Carysaurus/BrownCat_Free_Carysaurus/Brown-Idle.png").get_image().get_region(Rect2(0,0,48, 48))
	im = im.get_region(Rect2(im.get_width()/5,im.get_height()/4, im.get_width(), im.get_height()))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("MEEEOOOWWW!!!", self,person_name, tex)
		dialogueBox.setDialogueOption("Oh no! What's wrong??", 0)
		dialogueBox.setDialogueOption("I could kill you, ya know.", 1)
		dialogueBox.setDialogueOption("Oh shush.", 2)
	if(run==2):
		dialogueBox.dialogue("I lost my teddy bear *sad face*", self,person_name, tex)
		dialogueBox.setDialogueOption("I could go find it for you!", 0)
		dialogueBox.setDialogueOption("Whelp. Better put you down.", 1)
	if(run==6):
		dialogueBox.dialogue("Did you find it?", self,person_name, tex)
		dialogueBox.setDialogueOption("Yes! It's adorable!", 0)
		dialogueBox.setDialogueOption("No, not yet...", 1)
	if(run==3):
		dialogueBox.dialogue("A baby with a gun could too. You're nothing special.", self,person_name, tex)
		dialogueBox.setDialogueOption("FEEL MY WRATH!!!", 0)
		dialogueBox.setDialogueOption("Oh you right. Never mind. Do you need something?", 1)
	if(run==4):
		dialogueBox.dialogue("Thank you so much!", self,person_name, tex)
		dialogueBox.setDialogueOption("Aren't you supposed to help me fight the evil big cat now?", 0)
	if(run==5):
		dialogueBox.dialogue("Ugh fine.", self,person_name, tex)
		dialogueBox.setDialogueOption("Thanks.", 0)

func playerResponse(key:int):
	if(run==1):
		if(key==0):
			run=2
			interact()
		if(key==1):
			run=3
			interact()
		if(key==2):
			pass
	else: if(run==2):
		if(key==0):
			tamingQuest.activate()
			pass
		if(key==1):
			get_parent().setCombat(true)
	else: if(run==6):
		if(key==0):
			tamingQuest.tryComplete()
			if(tamingQuest.isComplete()):
				run=4
		if(key==1):
			pass
	else: if(run==3):
		if(key==0):
			get_parent().setCombat(true)
		else: if key==1:
			run=2
			interact()
	else: if(run==4):
		run=5
		interact()
	else: if(run==5):
		get_parent().questComplete()
