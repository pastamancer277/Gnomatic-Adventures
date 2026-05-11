extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Ruth"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/GoldGnome.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		if(player.socialCredit >=55):
			dialogueBox.dialogue("Hello! Would you like to buy some jewelry? I have a very large selection", self,person_name, tex)
			dialogueBox.setDialogueOption("Oh, they all look soooo pretty.", 0)
			dialogueBox.setDialogueOption("I don't think I can choose.", 1)
		else:
			dialogueBox.dialogue("I don't think you have enough money or class to buy from me.", self,person_name, tex)
			dialogueBox.setDialogueOption("Rude", 2)
			dialogueBox.setDialogueOption("Hey! I definitely do", 3)
	if(run == 2):
		dialogueBox.dialogue("Oh, wait. I forgot my parents said I couldn't sell my jewelry to strangers, sorry.", self,person_name, tex)
		dialogueBox.setDialogueOption("Oh, okay.", 0)
		dialogueBox.setDialogueOption("That's too bad.", 1)
	if(run == 3):
		dialogueBox.dialogue("Too bad, so sad! *sticks tounge out*", self,person_name, tex)
		dialogueBox.setDialogueOption("Wow", 0)
		dialogueBox.setDialogueOption("Didn't see that one coming.", 1)

func playerResponse(key: int):
	if(run == 1):
		if(key == 0 or key == 1):
			run +=1
			interact()
		if(key == 3):
			run = 3
			interact()
