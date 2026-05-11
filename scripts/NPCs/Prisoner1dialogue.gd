extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Jef"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/prisoner1.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Hey youngin enyoy your life outa jail, turn your life around or something ", self,person_name, tex)
		dialogueBox.setDialogueOption("I will thank you", 0)
		dialogueBox.setDialogueOption("Nah I'm gonna keep living the same", 1)

func playerResponse(key: int):
	if(run == 1):
		pass
