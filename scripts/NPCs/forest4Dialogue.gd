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
		dialogueBox.dialogue("There's a dangerous cat over there! You may not pass until that cat is gone!", self,person_name, tex)
		dialogueBox.setDialogueOption("Fine. I'll deal with it myslef.", 0)
		dialogueBox.setDialogueOption("I got rid of the cat. You should really pay me.", 1)
	else: if(run==2):
		dialogueBox.dialogue("I can still see the cat, pal.",self,person_name, tex)
		dialogueBox.setDialogueOption("Can you blame me for trying?", 0)
	else: if(run==3):
		dialogueBox.dialogue("That was almost cool. You can pass.",self,person_name, tex)
		dialogueBox.setDialogueOption("Great, thanks.", 0)
	else: if(run==4):
		dialogueBox.dialogue("I already said you can pass.",self,person_name, tex)
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
		player.addKeyword("black_cat_path_open")
		interact()
	else: if(run==4):
		pass
