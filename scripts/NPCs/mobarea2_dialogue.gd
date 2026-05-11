extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Niobe"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/MobGnome3.png").get_image()
	im = im.get_region(Rect2(im.get_width()/4,im.get_height()/10, im.get_width()/2, im.get_height()/1.5))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("You, kid, don't look like you could handle yourself. You better watch out, we don't like village kids in these parts.", self,person_name, tex)
		dialogueBox.setDialogueOption("How did you know I was a village kid?", 0)
		dialogueBox.setDialogueOption("Oh, sorry, I'll just stay over there...", 1)
	if(run==2):
		dialogueBox.dialogue("I would say we can smell it, but no one self-respecting person wears a backpack in the city. You're just begging to be robbed. And all citygnomes know to avoid this place, so clearly you're stupid enough to not know better.", self,person_name, tex)
		dialogueBox.setDialogueOption("Hey!", 0)
		dialogueBox.setDialogueOption("Oh...", 1)

func playerResponse(key: int):
	if(run == 1):
		if(key == 0):
			run+=1
			interact()
