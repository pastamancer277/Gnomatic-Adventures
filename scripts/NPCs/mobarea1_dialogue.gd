extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Jianna"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/MobGnome2.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("You, kid. You shouldn't be here", self,person_name, tex)
		dialogueBox.setDialogueOption("I wanna learn more about cats and gnomes!", 0)
		dialogueBox.setDialogueOption("Oh, okay, I'll leave...", 1)
	if(run==2):
		dialogueBox.dialogue("Oh, nevermind, you are definitely in the right place. I hope you haven't been talking like that around other gnomes. Where you from kid?", self,person_name, tex)
		dialogueBox.setDialogueOption("The village", 0)
		dialogueBox.setDialogueOption("None of your business", 1)
	if(run==3):
		dialogueBox.dialogue("Oh you really shouldn't have been talking like that. But you sure you wanna hear about cats? Once you now, you can never go back...", self,person_name, tex)
		dialogueBox.setDialogueOption("Of course I'm ready!", 0)
		dialogueBox.setDialogueOption("I need to understand.", 1)
		dialogueBox.setDialogueOption("That might be a bit much...", 2)
	if(run==4):
		dialogueBox.dialogue("Oh, so we're gonna be like that? I doubt you'd be able to handle it anyways.", self,person_name, tex)
		dialogueBox.setDialogueOption("No, I promise I can handle it!", 0)
		dialogueBox.setDialogueOption("I guess", 1)
	if(run==5):
		dialogueBox.dialogue("Well, rumor has it that an upstart gnome from Upper Village decided a few hundred years ago it would be fun to pull a prank on one of his cat friend's father. Well, lets just say most cats are a fan of water, and that cat was no longer friends with that gnome and may have learn magic to 'prank' him back and passed it on to his decendants.", self,person_name, tex)
		dialogueBox.setDialogueOption("I'm from the Upper Village...", 0)
		dialogueBox.setDialogueOption("That's crazy...", 1)
	if(run==6):
		dialogueBox.dialogue("I doubt that will count against you in a cat's eyes... but maybe keep that to yourself 'round here.", self,person_name, tex)
		dialogueBox.setDialogueOption("Okay, thank you.", 0)
		dialogueBox.setDialogueOption("I can hardly believe that.", 1)

func playerResponse(key: int):
	if(run == 1):
		if(key ==0):
			run+=1
			interact()
	elif(run == 2):
		if(key == 0):
			run +=1
			interact()
		if(key == 1):
			run =4
			interact()
	elif(run == 3):
		if(key == 0 or key == 1):
			run =5
			interact()
		if(key == 2):
			pass
	elif(run == 4):
		if(key == 0):
			run+=1
			interact()
		if(key == 1):
			pass
	elif(run == 5):
		if(key == 0):
			run+=1
			interact()
