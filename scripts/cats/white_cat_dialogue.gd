extends dialogue

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		dialogueBox.dialogue("YOU KILLED MY FIRENDS!!!", self)
		dialogueBox.setDialogueOption("...", 0)
	if(run==2):
		dialogueBox.dialogue("PREPARE TO MEET YOUR GOD!!!", self)
		dialogueBox.setDialogueOption("...", 0)

func playerResponse(key: int):
	if(run==1):
		run+=1
		interact()
	else: if(run==2):
		get_parent().setCombat(true)
