extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Fred"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/NPC1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,0, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("I've heard there is a farmer who sells pomegranates. He lives past the village.", self,person_name, tex)
		dialogueBox.setDialogueOption("Thank you!", 0)

func playerResponse(key: int):
	if(run == 1):
		pass
