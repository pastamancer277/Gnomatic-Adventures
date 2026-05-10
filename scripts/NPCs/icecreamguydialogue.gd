extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Judy"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/IcecreamGuy.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Have you seen any ice cream around here?", self, person_name, tex)
		dialogueBox.setDialogueOption("No, I'm so sorry.", 0)
		dialogueBox.setDialogueOption("No, but I can look for some.", 1)
		dialogueBox.setDialogueOption("Yeah, obviously", 2)
	if(run == 2):
		dialogueBox.dialogue("Yeah, it's so sad. I love ice cream...", self, person_name, tex)
		dialogueBox.setDialogueOption("Yeah me too.", 0)
		dialogueBox.setDialogueOption("...", 1)
	if(run == 3):
		dialogueBox.dialogue("YOU CAN'T! THERE'S NO ICE CREAM ANYWHERE. THESE GNOMES DON'T APPRICIATE IT ENOUGH! I just really want some...", self, person_name, tex)
		dialogueBox.setDialogueOption("I'm sorry", 0)
		dialogueBox.setDialogueOption("...", 1)
	

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
		else: if(key==1 or key ==2 ):
			run+=2
		interact()
	elif(run ==2):
		pass
	elif(run ==3):
		pass
	
