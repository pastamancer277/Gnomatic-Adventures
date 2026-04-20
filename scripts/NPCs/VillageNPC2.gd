extends dialogue

@onready var player = $/root/Main/Sort/PlayerEntities/Player

func _ready() -> void:
	dialogueBox=$/root/Main/UI/Dialogue

func interact():
	if(run==1):
		dialogueBox.dialogue("The farmer lives just up this path. His specialty is pomegranates.", self)


func playerResponse(key: int):
	if(run == 1):
		pass
