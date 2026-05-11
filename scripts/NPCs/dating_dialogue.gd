extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player
var tex2
var person_name2
func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Michael"
	person_name2 = "Michelle"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/MaleGnome2.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	tex2 = PortableCompressedTexture2D.new()
	im = load("res://assets/sprites/characters/femalegnome4.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex2.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)


func interact():
	if(run==1):
		dialogueBox.dialogue("Oh hello! This is my wonderful, amazing, beautiful, ethereal, all the good adjectives girlfriend", self,person_name, tex)
		dialogueBox.setDialogueOption("Oh, umm, how long have you been together?", 0)
		dialogueBox.setDialogueOption("Ugh get a room.", 1)
		dialogueBox.setDialogueOption("Dang, you are such a simp", 2)
	if(run==2):
		dialogueBox.dialogue("Oh, stop. We've been dating for about a month. I think he's still in his honeymoon phase.", self,person_name2, tex2)
		dialogueBox.setDialogueOption("Oh, that's sweet I guess. ", 0)
		dialogueBox.setDialogueOption("I wish you luck.", 1)

func playerResponse(key: int):
	if(run == 1):
		if(key == 0):
			run+=1
			interact()
