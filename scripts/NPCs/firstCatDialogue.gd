extends dialogue

var catPieQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player
@onready var Pie_item: Item = preload("res://resources/items/Pie.tres")

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	tex = PortableCompressedTexture2D.new()
	person_name = "Friendly Cat"
	var im = load("res://assets/sprites/characters/OrangeTabby.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/3, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	catPieQuest=get_node("../Quests/catPieQuest")

func interact():
	if(run==1):
			dialogueBox.dialogue("Hello, Gnome!", self, person_name, tex)
			dialogueBox.setDialogueOption("OH MY GNOMENESS A CAT! GET AWAY!.", 0)
			dialogueBox.setDialogueOption("Please don't eat me!", 0)
	else: if(run==2):
		dialogueBox.dialogue("Woah, relax! I just want some pie!",self, person_name, tex)
		dialogueBox.setDialogueOption("You're lying, you just want to eat me! Everyone knows only Gnomes love pie.", 0)
	else: if(run==3):
		dialogueBox.dialogue("We cats like pie and blueberrys, just the same as Gnomes, I just want to be friends.",self,person_name, tex)
		dialogueBox.setDialogueOption("Okay! I'll find you a pie, just don't eat me!.", 0)
	else: if (run==4):
		dialogueBox.dialogue("Do you have the pie?",self,person_name, tex)
		dialogueBox.setDialogueOption("yes, right here!", 0)
		dialogueBox.setDialogueOption("No, not yet", 1)
	else: if(run==5):
		dialogueBox.dialogue("I'm sorry but it doesn't look like you do.", self,person_name, tex)
		dialogueBox.setDialogueOption("sorry, I'll get on that.", 0)
	else: if(run==6):
		dialogueBox.dialogue("Thank you so much! We're friends now, whether you like it or not.",self,person_name, tex)
		dialogueBox.setDialogueOption("Wow, you really didn't eat me. Thank you!", 0)
	else: if(run==7):
		dialogueBox.dialogue("Yes, of course! If it's okay, I would ask that you please be friendly to fellow cats, I know we have a bad reputation, but many of us are controlled by the evil wizard cat. It's out of our control that we are hostile towards Gnomes. Our species actually used to get along. If the wizard cat were defeated, most cats would happily live in harmony with the gnomes!", self,person_name, tex)
		dialogueBox.setDialogueOption("Okay, I'll keep that in mind. Maybe one day, I could defeat the wizard cat and we could live in harmony.", 0)
	else: if (run==8):
		dialogueBox.dialogue("Please tell the baker of this pie I thank them!", self, person_name, tex)
		dialogueBox.setDialogueOption("Bye friend!", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
	else: if(run==2):
		if(key==0):
			run+=1
			interact()
	else: if(run==3):
		if(key==0):
			catPieQuest.activate()
			run+=1
			pass
	else: if(run==4):
		interact()
		if(key==0):
			catPieQuest.tryComplete()
			if(catPieQuest.isComplete()):
				run+=2
				interact()
			else:
				run+=1
				interact()
	else: if(run==5):
		if(key==0):
			run-=1
			pass
	else: if(run==6):
		run+=1
		interact()
	else: if(run==7):
		run+=1
		interact()
	else: if(run==8):
		run+=1
		pass
