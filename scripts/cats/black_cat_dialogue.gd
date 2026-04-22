extends dialogue

var tamingQuest

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	tamingQuest=get_node("../Quests/TamingQuest")
	person_name = "Black Cat"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/BrownCat_Free_Carysaurus/BrownCat_Free_Carysaurus/Brown-Idle.png").get_image().get_region(Rect2(0,0,48, 48))
	im = im.get_region(Rect2(im.get_width()/5,im.get_height()/4, im.get_width(), im.get_height()))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Are you here to help me?", self,person_name, tex)
		dialogueBox.setDialogueOption("Of course!", 0)
		dialogueBox.setDialogueOption("No, I'm here to fight!", 1)
		dialogueBox.setDialogueOption("I'm just passing through...", 2)
	if(run==2):
		dialogueBox.dialogue("Great! I need three fish and five meat!", self,person_name, tex)
		dialogueBox.setDialogueOption("Here you go!", 0)
		dialogueBox.setDialogueOption("Give me a second.", 1)
	if(run==3):
		dialogueBox.dialogue("Fine then...", self,person_name, tex)
		dialogueBox.setDialogueOption("CHARGE!", 0)
	if(run==4):
		dialogueBox.dialogue("I will join you in your quest!", self,person_name, tex)
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
