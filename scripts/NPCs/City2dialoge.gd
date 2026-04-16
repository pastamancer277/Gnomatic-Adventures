extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		dialogueBox.dialogue("I heard there is a farmer who sells polmegranates. He lives past the village", self)


func playerResponse(key: int):
	if(run == 1):
		pass
