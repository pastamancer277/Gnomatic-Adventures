extends dialogue

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Evil Cat"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/WhiteCat_Free_Carysaurus/WhiteCat_Free_Carysaurus/White-Idle.png").get_image().get_region(Rect2(0,0,48, 48))
	im = im.get_region(Rect2(im.get_width()/5,im.get_height()/4, im.get_width(), im.get_height()))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("YOU KILLED MY FIRENDS!!!", self, person_name, tex)
		dialogueBox.setDialogueOption("...", 0)
	if(run==2):
		dialogueBox.dialogue("PREPARE TO MEET YOUR GOD!!!", self, person_name, tex)
		dialogueBox.setDialogueOption("...", 0)

func playerResponse(key: int):
	if(run==1):
		run+=1
		interact()
	else: if(run==2):
		get_parent().setCombat(true)
