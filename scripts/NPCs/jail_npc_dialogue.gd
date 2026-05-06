extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player
var blocking

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Guard"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(not blocking):
		dialogueBox.dialogue("You do not need to stay here", self, person_name, tex)
		dialogueBox.setDialogueOption("I know", 0)
	else: if(run==1):
		dialogueBox.dialogue("Would you like to leave?", self, person_name, tex)
		dialogueBox.setDialogueOption("Yes, please", 0)
		dialogueBox.setDialogueOption("No! I don't have to pay rent here", 1)
	else: if(run==2):
		dialogueBox.dialogue("Then what does the Code of Law say about murder?", self, person_name, tex)
		dialogueBox.setDialogueOption("Don't do it", 0)
		dialogueBox.setDialogueOption("Kill everyone!!!", 1)
	else: if(run==3):
		dialogueBox.dialogue("Lastly what is the law about accessories?", self, person_name, tex)
		dialogueBox.setDialogueOption("Always wear something on your head!", 0)
		dialogueBox.setDialogueOption("Umm...", 1)
		dialogueBox.setDialogueOption("I hate hats! And gnome fashion!", 2)
	else: if(run==4):
		dialogueBox.dialogue("You know the law now. You are free to go, I guess.", self, person_name, tex)
		dialogueBox.setDialogueOption("Yay!!!", 0)
		dialogueBox.setDialogueOption("Don't worry. I'll be back!", 1)

func playerResponse(key: int):
	if(not blocking):
		pass
	else: if(run==1):
		if(key==0):
			run+=1
			interact()
	else: if(run==2):
		if(key==0):
			run+=1
			interact()
		elif (key == 1):
			run=1
	else: if(run==3):
		if(key==0):
			run+=1
			interact()
		elif key == 1:
			run = 1
	else: if(run==4):
		if(key==0 or key ==1):
			get_parent().leave()
			run=1
