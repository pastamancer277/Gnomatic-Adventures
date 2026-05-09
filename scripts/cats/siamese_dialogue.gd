extends dialogue


func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Siamese Cat"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/SiameseCat-Free-Carysaurus/SiameseCat-Free-Carysaurus/Siamese-Idle.png").get_image().get_region(Rect2(0,0,48, 48))
	im = im.get_region(Rect2(im.get_width()/5,im.get_height()/4, im.get_width(), im.get_height()))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("So you are the one planning on fighting the evil wizard cat?", self,person_name, tex)
		dialogueBox.setDialogueOption("Who's asking?", 0)
		dialogueBox.setDialogueOption("I would never!", 1)
		dialogueBox.setDialogueOption("Yeah, why?", 2)
	if(run==2):
		dialogueBox.dialogue("I am not under their control, and would like to help you in your journey. My family is endangered by their actions.", self,person_name, tex)
		dialogueBox.setDialogueOption("Okay great. Let's go.", 0)
	if(run==3):
		dialogueBox.dialogue("First, you must prove yourself in battle against me!", self,person_name, tex)
		dialogueBox.setDialogueOption("Then let us fight!", 0)
	if(run==4):
		dialogueBox.dialogue("You are worthy. Let us vanquish evil from the lands!", self,person_name, tex)
		dialogueBox.setDialogueOption("A valiant thought.", 0)
	if(run==5):
		dialogueBox.dialogue("I am a siamese cat, not some weak little stray!", self,person_name, tex)
		dialogueBox.setDialogueOption("Okay, and?", 0)

func playerResponse(key:int):
	if(run==1):
		if(key==0):
			run=5
			interact()
		if(key==2):
			run=2
			interact()
		if(key==1):
			pass
	else: if(run==2):
		run=3
		interact()
	else: if(run==3):
		get_parent().setCombat(true)
		run=4
	else: if(run==4):
		get_parent().questComplete()
		get_parent().clearSpikes()
	else: if(run==5):
		run=2
		interact()
