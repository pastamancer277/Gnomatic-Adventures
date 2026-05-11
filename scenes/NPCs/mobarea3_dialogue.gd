extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Everest"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/MobGnome4.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("I was once a towngnome too. If you need a friend to stick to, I've got you. The gnome-cat relationship is messed up on both sides.", self,person_name, tex)
		dialogueBox.setDialogueOption("How does everyone just know I'm from the village!", 0)
		dialogueBox.setDialogueOption("Thank you, I appriciate it.", 1)
	if(run==2):
		dialogueBox.dialogue("Only towngnomes wear backpacks in the city and would unknowingly wander into the mob area. I would know, I did it too.", self,person_name, tex)
		dialogueBox.setDialogueOption("Oh, at least I'm not alone.", 0)
		dialogueBox.setDialogueOption("Backpacks are just convenient!", 1)
	if(run==3):
		dialogueBox.dialogue("Well, you'll always have me, kid.", self,person_name, tex)
		dialogueBox.setDialogueOption("Thanks.", 0)
		dialogueBox.setDialogueOption("It feels good to have a friend.", 1)
	if(run==4):
		dialogueBox.dialogue("I know right? These citygnomes and their worries of robbery...", self,person_name, tex)
		dialogueBox.setDialogueOption("Does seem like a legit concern", 0)
		dialogueBox.setDialogueOption("Just don't get robbed right?", 1)

func playerResponse(key: int):
	if(run == 1):
		if(key == 0):
			run+=1
			interact()
	elif(run == 2):
		if(key == 0):
			run+=1
			interact()
		if(key == 1):
			run = 4
			interact()
	elif(run == 4):
		run = 3
		interact()
