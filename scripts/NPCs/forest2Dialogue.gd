extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	tex = PortableCompressedTexture2D.new()
	person_name = "Guard"
	var im = load("res://assets/sprites/characters/Idle-Guard1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/4,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("There's a dangerous cat somewhere in this forest! I'm sorry, but I can't let anyone through until the cat is dealt with, and I'm afraid The Catwatch Crew won't be dispatched until a couple days from now. So unless YOU want to deal with it, you cannot pass.", self,person_name, tex)
		dialogueBox.setDialogueOption("I'll go find that cat and deal with it myself.", 0)
		dialogueBox.setDialogueOption("I already dealt with it", 1)
	else: if(run==2):
		dialogueBox.dialogue("My gnome senses tell me there's still danger in this forest. I know you're lying.",self,person_name, tex)
		dialogueBox.setDialogueOption("Well you don't have to be so rude about it", 0)
	else: if(run==3):
		dialogueBox.dialogue("Wow! That's impressive! I suppose I can reopen the path.",self,person_name, tex)
		dialogueBox.setDialogueOption("Great, thanks.", 0)
	else: if(run==4):
		dialogueBox.dialogue("The path is open.",self,person_name, tex)
		dialogueBox.setDialogueOption("Thank you.", 0)

func playerResponse(key: int):
	if(run==1):
		if(key==0):
			pass
		else: if(key==1):
			if(player.hasKeyword("black_cat")):
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
		player.addKeyword("forest_clear")
		interact()
	else: if(run==4):
		pass
