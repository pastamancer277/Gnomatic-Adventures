extends dialogue

var catPieQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	catPieQuest=get_node("../Quests/catPieQuest")
	person_name = "Grandma"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
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
	
func playerResponse(key: int):
	if(run == 1):
		if(key==0 or key==1):
			run+=1
			interact()
	else: if(run==2):
		if(key==0):
			run+=1
	else: if(run==3):
		if(key==0):
				run+=1
				interact()
		if(key==1):
			pass
	else: if(run==5):
		if(key==0):
			pass
