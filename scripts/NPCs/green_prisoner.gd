extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Chad"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/greenPrisoner.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("Yo bro, ain't it so cool in here? I love being here, it's probably my 6 or 7th time.", self,person_name, tex)
		dialogueBox.setDialogueOption("Umm, I don't really like it...", 0)
		dialogueBox.setDialogueOption("Oh My Gosh, YES. You're my person!", 1)
		dialogueBox.setDialogueOption("Haha, 67 67", 1)

func playerResponse(key: int):
	if(run == 1):
		pass
