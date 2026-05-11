extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Lucky"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/prisoner3.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("I'M FREE!! You don't know how long I've waited for this kid... you may have gotten in and out, but most of us aren't that lucky.", self,person_name, tex)
		dialogueBox.setDialogueOption("YAY!", 0)
		dialogueBox.setDialogueOption("Yada yada old man", 1)

func playerResponse(key: int):
	if(run == 1):
		pass
