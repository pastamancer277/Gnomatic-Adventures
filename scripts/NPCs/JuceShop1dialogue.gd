extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Judy"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/JuiceGuy.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			dialogueBox.dialogue("Hello there! Sorry, we are out of juice. A guy in sunglasses ordered the last of our stock.", self, person_name, tex)
			dialogueBox.setDialogueOption("Aww that's too bad. nice shop though!", 0)
			dialogueBox.setDialogueOption("Ugh, ok.", 1)
		else:
			dialogueBox.dialogue("This Duck is so annyoing, constantly going on about pomegranates", self. person_name, tex)
			dialogueBox.setDialogueOption("...", 2)
	
	

func playerResponse(key: int):
	if(run == 1):
		if(key==0):
			run+=1
			interact()
		else: if(key==1):
			pass
		else:
			pass
	
