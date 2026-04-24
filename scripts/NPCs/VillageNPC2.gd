extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue
	person_name = "Virginia"
	tex = PortableCompressedTexture2D.new()
	var im = load("res://assets/sprites/characters/JuiceGuy.png").get_image()
	im = im.get_region(Rect2(im.get_width()/3,im.get_height()/7, im.get_width()/2, im.get_height()/2))
	tex.create_from_image(im, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

func interact():
	if(run==1):
		dialogueBox.dialogue("The farmer lives just up this path. His specialty is pomegranates. Everyone knows gnomes LOVE pomegranates.", self,person_name, tex)
		dialogueBox.setDialogueOption("Thank you!", 0)


func playerResponse(key: int):
	if(run == 1):
		pass
