extends dialogue

var slimeQuest
@onready var player = $/root/Main/Sort/PlayerEntities/Player


func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	slimeQuest=get_node("../Quests/SlimeQuest")
	person_name = "Fred"
	tex = PortableCompressedTexture2D.new()
	
	var im = load("res://assets/sprites/characters/Kid.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_width()/10, im.get_width()/2, im.get_height()/2))
	#var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	#im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			#dialogueBox.dialogue("Hello there", self, name, tex)
			#dialogueBox.setDialogueOption("Hi", 0)
			#dialogueBox.setDialogueOption("Ugh, people", 1)
			dialogueBox.dialogue("Hi, can you help me?!", self,person_name, tex)
			dialogueBox.setDialogueOption("Hi, of course I can help.", 0)
			dialogueBox.setDialogueOption("No kid, i have better things to do.", 1)
		else:
			dialogueBox.dialogue("I don't know you. Come back when you're more popular.", self,person_name, tex)
			dialogueBox.setDialogueOption("...", 2)
	else: if(run==2):
		dialogueBox.dialogue("Can you kill those animals and bring me the fur?",self ,person_name, tex)
		dialogueBox.setDialogueOption("Sure!", 0)
		dialogueBox.setDialogueOption("Fine, I suppose.", 1)
		dialogueBox.setDialogueOption("No, I'm busy.", 2)
	else: if(run==3):
		dialogueBox.dialogue("Have you killed the animals?",self,person_name, tex)
		dialogueBox.setDialogueOption("Yeah, here", 0)
		dialogueBox.setDialogueOption("No", 1)
	else: if run ==4:
		run = 5
	else: if(run==5):
		dialogueBox.dialogue("Thank you so much!",self,person_name, tex)
		dialogueBox.setDialogueOption("You're welcome.", 0)

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
		else:
			pass
	else: if(run==2):
		if(key==0 or key==1):
			run+=1
			slimeQuest.activate()
		if(key==2):
			pass
	else: if(run==3):
		if(key==0):
			slimeQuest.tryComplete()
			if(slimeQuest.isComplete()):
				run+=1
				interact()
				var popup_scene = load("res://scenes/popups.tscn").instantiate()
				$"/root/Main/UI/Popups".add_child(popup_scene)
				popup_scene.set_text("You gained a key! There must be a chest somewhere...")
				$/root/Global.multiple_popups()
		if(key==1):
			pass
	else: if(run==5):
		if(key==0):
			pass
