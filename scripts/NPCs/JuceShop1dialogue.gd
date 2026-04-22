extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		if(player.getSocialCredit()>50):
			dialogueBox.dialogue("Hello there! Sorry, we are out of juice. A guy in sunglasses ordered the last of our stock.", self)
			dialogueBox.setDialogueOption("Aww that's too bad. nice shop though!", 0)
			dialogueBox.setDialogueOption("Ugh, ok.", 1)
		else:
			dialogueBox.dialogue("This Duck is so annyoing, constantly going on about pomegranates", self)
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
	
