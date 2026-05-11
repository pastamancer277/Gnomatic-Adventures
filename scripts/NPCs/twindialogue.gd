extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player
var tex2
var person_name2
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Maddie"
	person_name2 = "Isabelle"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/femalegnome1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	tex2 = PortableCompressedTexture2D.new()
	im = load("res://assets/sprites/characters/femalegnome2.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex2.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Hello friend! I'm Maddie!", self, person_name, tex)
		dialogueBox.setDialogueOption("...", 0)
	if(run == 2):
		dialogueBox.dialogue("And I'm Isabelle!", self, person_name2, tex2)
		dialogueBox.setDialogueOption("...", 0)
	if(run == 3):
		dialogueBox.dialogue("We're sisters. Twins actually.", self, person_name, tex)
		dialogueBox.setDialogueOption("...", 0)
	if(run == 4):
		dialogueBox.dialogue("Multiple children used to be good luck... But ever since we started hating cats, its been bad luck. Ya know, since cats have so many babies at once...", self, person_name2, tex2)
		dialogueBox.setDialogueOption("That must be hard.", 0)
		dialogueBox.setDialogueOption("I'm sorry", 1)
	if(run == 5):
		dialogueBox.dialogue("If only someone was able to make cats and gnomes friends again...", self, person_name, tex)
		dialogueBox.setDialogueOption("That'll be me!", 0)
		dialogueBox.setDialogueOption("I hope someone come and helps you.", 1)
	if(run == 6):
		dialogueBox.dialogue("Thank you so much!", self, person_name2, tex2)
		dialogueBox.setDialogueOption("You're welcome", 0)
		dialogueBox.setDialogueOption("Of course", 1)

func playerResponse(key: int):
	if run == 1:
		run+=1 
		interact()
	elif run == 2:
		run+=1 
		interact()
	elif run == 3:
		run+=1 
		interact()
	elif run == 4:
		run+=1 
		interact()
	elif run == 5:
		run+=1 
		interact()
	elif run == 6:
		pass
