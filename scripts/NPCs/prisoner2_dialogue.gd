extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Maurice"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/prisoner2.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("I wish gnomes weren't forced to wear hats all the time... I just want my head to breathe.", self,person_name, tex)
		dialogueBox.setDialogueOption("Nah, I like my hat!", 0)
		dialogueBox.setDialogueOption("Me too!", 1)

func playerResponse(key: int):
	if(run == 1):
		pass
