extends npc

func leave():
	global_position = $"../Teleport Points/Free".global_position
	$Dialogue.blocking = false

func block():
	global_position = $"../Teleport Points/Block".global_position
	$Dialogue.blocking = true

func damage(d: int, pos, knock):
	pass
