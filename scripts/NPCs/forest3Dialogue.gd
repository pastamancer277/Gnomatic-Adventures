extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Jack"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/LumberJack.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("I need wood. Would you go hunt for a wood sprite to get some for me?.", self,person_name, tex)
		dialogueBox.setDialogueOption("Ok!", 0)
		dialogueBox.setDialogueOption("I have your wood right here, sir.", 1)
	else: if(run==2):
		dialogueBox.dialogue("I think I'll need more.",self,person_name, tex)
		dialogueBox.setDialogueOption("Ah, okay.", 0)
	else: if(run==3):
		run=4
	else: if(run==4):
		dialogueBox.dialogue("Thanks again.",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome!", 0)
		dialogueBox.setDialogueOption("Bye!", 0)

func playerResponse(key: int):
	if(run==1):
		if(key==0):
			pass
		else: if(key==1):
			get_node("../Quests/WoodQuest").tryComplete()
			if(get_node("../Quests/WoodQuest").isComplete()):
				run=3
				interact()
			else:
				run=2
				interact()
	else: if(run==2):
		run=1
		interact()
	else: if(run==3):
		run=4
		interact()
	else: if(run==4):
		pass
