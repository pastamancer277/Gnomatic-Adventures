extends dialogue

var catPieQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	catPieQuest=get_node("../Quests/catPieQuest")
	person_name = "Grandma"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/Grandma.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/9, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Hello my grandchild.", self,person_name, tex)
		dialogueBox.setDialogueOption("Hi Grandma!", 0)
		dialogueBox.setDialogueOption("Guess what I did today, Grandma!", 1)
	else: if(run==2):
		dialogueBox.dialogue("What did you do today, little one?",self,person_name, tex)
		dialogueBox.setDialogueOption("I befriended a cat!", 0)
	else: if(run==3):
		dialogueBox.dialogue("OH MY GNOMENESS!! A cat!?",self,person_name, tex)
		dialogueBox.setDialogueOption("Yes! A cat, I thought they were all evil but this one was nice!", 0)
	else: if (run ==4):
		dialogueBox.dialogue("All cats are dangerous, there is no such thing.", self, person_name, tex)
		dialogueBox.setDialogueOption("I'm telling you, this one wasn't dangerous. It actually likes pomegranate pie, just like us.", 0)
	else: if(run==5):
		dialogueBox.dialogue("The era of cats and gnomes being friends was long ago, I'm afraid it's impossible.",self,person_name, tex)
		dialogueBox.setDialogueOption("All cats and gnomes used to be friends?", 0)
	else: if(run==6):
		dialogueBox.dialogue("Yes, but I will tell you the story some other time. For now, I forbid you from visiting this 'friendly' cat. If the townsgnomes found out, you would surely be banned from the village.",self,person_name, tex)
		dialogueBox.setDialogueOption("Okay, Grandma.", 0)
	else: if(run==7):
		dialogueBox.dialogue("Now now, there's a pomegranate pie in the oven for you.",self,person_name, tex)
		dialogueBox.setDialogueOption("Ohhh boy, thank you!!", 0)
		
	else: if(run==8):
		dialogueBox.dialogue("Did you give the pie to the CAT?!",self,person_name, tex)
		dialogueBox.setDialogueOption("How'd you know! And so what, it's my friend!", 0)
	else: if(run==9):
		dialogueBox.dialogue("One of the watch-gnomes from the village saw you talking to the cat and giving it the pie. The village security has deemed you a cat-sympathiser, they're on their way to kick you out of the village. I'm sorry.",self,person_name, tex)
		dialogueBox.setDialogueOption("I'll make this right. I show gnomekind that cats don't have to be bad.", 0)
		
	
func playerResponse(key: int):
	if(run == 1):
		interact()
		if(key==0 or key==1):
			run+=1
			interact()
	else: if(run==2):
		if(key==0):
			run+=1
			interact()
	else: if(run==3):
		if(key==0):
			run+=1
			interact()
	else: if(run==4):
		if(key==0):
			run+=1
			interact()
	else: if(run==5):
		if(key==0):
			run+=1
			interact()
	else: if(run==6):
		if(key==0):
			run+=1
			interact()
	else: if(run==7):
		if(player.hasKeyword("catHasPie")):
			run+=1
		if(key==0):
			pass
	#other dialogue string starts here.
	else: if(run==8):
		if(player.hasKeyword("catHasPie")):
			run+=1
			interact()
		else:
			pass
	else: if(run==7):
		if(key==0):
			run+=1
			interact()
	else: if(run==8):
		if(key==0):
			run+=1
			interact()
	else: if(run==9):
		player.changeCredit(-2)
		if(key==0):
			pass
