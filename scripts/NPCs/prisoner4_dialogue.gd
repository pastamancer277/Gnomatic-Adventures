extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Charlie"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/prisoner4.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("HAHAH, they can't catch me and force me into a hat!!", self,person_name, tex)
		dialogueBox.setDialogueOption("Oh, woah", 0)
		dialogueBox.setDialogueOption("I wish I was that confident.", 1)

func playerResponse(key: int):
	if(run == 1):
		pass
