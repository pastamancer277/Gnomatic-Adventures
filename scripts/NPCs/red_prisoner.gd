extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Richard"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/redPrisoner.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Hey kid. I promise your life isn't over. I've been here a few times, but you'll always adapt once you're out. I promise.", self,person_name, tex)
		dialogueBox.setDialogueOption("Thanks...", 0)
		dialogueBox.setDialogueOption("I think I'll take a page out of your book!", 1)

func playerResponse(key: int):
	if(run == 1):
		pass
