extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			dialogueBox.dialogue("Hello there! sorry we are out of juice, a guy in sunglasses ordering it all", self)
			dialogueBox.setDialogueOption("Aww that's to bad, nice shop tho", 0)
			dialogueBox.setDialogueOption("Ugh, ok", 1)
		else:
			dialogueBox.dialogue("This Duck is so anyoing constantly going on about polmegranates", self)
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
	
